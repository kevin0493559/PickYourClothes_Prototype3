//
//  MainFunctionViewController.m
//  PickYourClothesCoreData
//
//  Created by Rui Yao on 4/18/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import "MainFunctionViewController.h"
#import "WXManager.h"
@interface MainFunctionViewController ()
@property (strong,nonatomic) NSArray *clothesArray;
@property (strong,nonatomic) NSArray *pantsArray;
@property (strong,nonatomic) NSMutableArray *clothesFilterArray;
@property (strong,nonatomic) NSMutableArray *pantsFilterArray;
@property (strong,nonatomic) NSMutableArray *shoesFilterArray;
@property (strong,nonatomic) NSMutableArray *umbrellaFilterArray;
@property (strong,nonatomic) NSMutableArray *gloveFilterArray;
@property (nonatomic) NSInteger currentTemperature;
@property (nonatomic,strong) WXCondition *weatherCondition;
@property (nonatomic) BOOL needUmbrella;
@property (nonatomic) BOOL needGlove;
@property (nonatomic) NSInteger cnt;
@property (nonatomic) BOOL lackOfClothes;
@property (nonatomic) BOOL lackOfPants;
@property (nonatomic) BOOL lackOfShoes;
@property (nonatomic) BOOL lackOfUmbrellas;
@property (nonatomic) BOOL lackOfGloves;
@property (nonatomic) NSString *shouldPickClothes;
@property (nonatomic) NSString *shouldPickPants;
@property (nonatomic) NSString *shouldPickShoes;
@property (nonatomic) Clothes *cloth;
@property (nonatomic) Clothes *pant;
@property (nonatomic) Clothes *shoes;
@end

@implementation MainFunctionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
    }
    return self;
}

-(void) findClothes{
    [[RACObserve([WXManager sharedManager], currentCondition)
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(WXCondition *newCondition) {
         _currentTemperature = newCondition.temperature.intValue;
         _weatherCondition=newCondition;
     }];
    [[WXManager sharedManager] findCurrentLocation];

    self.fetchrearch=nil;
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSManagedObjectContext *moc=kAppDelegate.managedObjectContext;
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Clothes" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc]initWithKey:@"name" ascending:NO];
    NSArray *sortDescription=[NSArray arrayWithObjects:sortDescriptor,nil];
    [fetchRequest setSortDescriptors:sortDescription];
    NSFetchedResultsController *aFetched=[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:moc sectionNameKeyPath:@"name" cacheName:nil];
    aFetched.delegate=self;
    self.fetchrearch=aFetched;
    NSError *error=nil;
    if (![self.fetchrearch performFetch:&error]) {
        abort();
    }
    _clothesArray=[self.fetchrearch fetchedObjects];
    
    

   //    NSLog(@"current is %i",_currentTemperature);
//    _shouldPickClothes = [[NSString alloc]init];
//    _shouldPickPants = [[NSString alloc]init];
//    _shouldPickShoes =[[NSString alloc]init];
    
    if([self.purpose isEqualToString:@"Formal Occasion"]){
        _shouldPickClothes=@"Suit";_shouldPickPants=@"Suit";_shouldPickShoes=@"Suit";
    }
    if([self.purpose isEqualToString:@"Exercise,Gym,Sports"]){
       if (_currentTemperature<50) {
           _shouldPickClothes = @"Sports Long"; _shouldPickPants = @"Sports Long";_shouldPickShoes=@"Exercise";
       }
       else{
           _shouldPickClothes =@"Sports Short"; _shouldPickPants = @"Sports Short";_shouldPickShoes=@"Exercise";
       }
    }
    if([self.purpose isEqualToString:@"Others"]){
        if (_currentTemperature<50) {
            _shouldPickClothes = @"Jacket"; _shouldPickPants = @"Pants Long";_shouldPickShoes=@"Warm Shoes";
        }
        else if(_currentTemperature<60){
            _shouldPickClothes =@"Sweater"; _shouldPickPants = @"Pants Long";_shouldPickShoes=@"Warm Shoes";
        }
        else if (_currentTemperature<70){
            _shouldPickClothes =@"Shirt"; _shouldPickPants = @"Pants Middle";_shouldPickShoes=@"Plimsolls";
        }else{
            _shouldPickClothes =@"T-shirt"; _shouldPickPants = @"Pants Short";_shouldPickShoes=@"Sandal";
        }
    }
    
    _clothesFilterArray=[[NSMutableArray alloc]initWithCapacity:50];
    _pantsFilterArray=[[NSMutableArray alloc]initWithCapacity:50];
    _shoesFilterArray=[[NSMutableArray alloc]initWithCapacity:50];
    _umbrellaFilterArray=[[NSMutableArray alloc]initWithCapacity:50];
    _gloveFilterArray=[[NSMutableArray alloc]initWithCapacity:50];
        for(Clothes *cloth in _clothesArray){
            if ([cloth.type isEqualToString:_shouldPickClothes]&&[cloth.kindOf isEqualToString:@"Jacketing"]) {
                [_clothesFilterArray addObject:cloth];
            }
            if ([cloth.type isEqualToString:_shouldPickPants]&&[cloth.kindOf isEqualToString:@"Pants"]) {
                [_pantsFilterArray addObject:cloth];
            }
            if ([cloth.type isEqualToString:_shouldPickShoes]&&[cloth.kindOf isEqualToString:@"Shoes"]) {
                [_shoesFilterArray addObject:cloth];
            }
            if ([cloth.kindOf isEqualToString:@"Umbrella"]) {
                [_umbrellaFilterArray addObject:cloth];
            }
            if ([cloth.kindOf isEqualToString:@"Glove"]) {
                [_gloveFilterArray addObject:cloth];
            }
        }
  

    if ([[_weatherCondition imageName] isEqualToString:@"weather-rain-night" ] ||  [[_weatherCondition imageName] isEqualToString:@"weather-rain" ] ||  [[_weatherCondition imageName] isEqualToString:@"weather-shower" ]||[[_weatherCondition imageName] isEqualToString:@"weather-snow" ]) {
        _needUmbrella=YES;
    }else{
        _needUmbrella=NO;
    }
    if (_currentTemperature<50) {
        _needGlove=YES;
    }else{
        _needGlove=NO;
    }
    

}
-(NSMutableArray *)generateFilterArray:(NSMutableArray *)initialArray{
    NSMutableArray *filterArray=[[NSMutableArray alloc]init];
    int count=0;
    for (int i=0; i<[initialArray count]; i++) {
        Clothes *cloth=initialArray[i];
        for (int j=0; j<cloth.rate.intValue+1; j++) {
            filterArray[count]=initialArray[i];
            count++;
        }
    }
    return filterArray;
}
-(void)showSelection{
    [self findClothes];
    if(_cnt!=0){
        _cloth=[Clothes alloc];
        _pant=[Clothes alloc];
        _shoes=[Clothes alloc];
        unsigned indexOfClothes;
        unsigned indexOfPants;
        unsigned indexOfShoes;
        NSMutableArray *clothesFilterArray2=[self generateFilterArray:_clothesFilterArray];
        NSMutableArray *pantsFilterArray2=[self generateFilterArray:_pantsFilterArray];
        NSMutableArray *shoesFilterArray2=[self generateFilterArray:_shoesFilterArray];
        
//if([clothesFilterArray2 count]!=0 && [pantsFilterArray2 count]!=0 && [shoesFilterArray2 count]!=0){
        if ([clothesFilterArray2 count]!=0) {
            self.lackOfClothes=NO;
            indexOfClothes =arc4random() % [clothesFilterArray2 count];
            _cloth=clothesFilterArray2[indexOfClothes];
            NSData *clothesImageData= _cloth.image;
            self.PickedClothes.image=[UIImage imageWithData:clothesImageData];
        }else{
            self.lackOfClothes=YES;
        }
        if ([pantsFilterArray2 count]!=0) {
            self.lackOfPants=NO;
            if([self.purpose isEqualToString:@"Formal Occasion"]){
                NSMutableArray *sameColorPants=[[NSMutableArray alloc]init];
                for(Clothes *possibleClothes in pantsFilterArray2){
                    if ([possibleClothes.color isEqualToString:_cloth.color]) {
                        [sameColorPants addObject:possibleClothes];
                    }
                }
                indexOfPants=arc4random() % [sameColorPants count];
                _pant=sameColorPants[indexOfPants];
            }else{
                indexOfPants =arc4random() % [pantsFilterArray2 count];
                 _pant=pantsFilterArray2[indexOfPants];
            }
            NSData *pantsImageData=_pant.image;
            self.PickedPants.image=[UIImage imageWithData:pantsImageData];
        }else{
            self.lackOfPants=YES;
        }
        if ([shoesFilterArray2 count]!=0) {
            self.lackOfShoes=NO;
            indexOfShoes =arc4random() % [shoesFilterArray2 count];
            _shoes=shoesFilterArray2[indexOfShoes];
            NSData *shoesImageData=_shoes.image;
            self.PickedShoes.image=[UIImage imageWithData:shoesImageData];
        }else{
            self.lackOfShoes=YES;
        }
        if (_needUmbrella) {
            Clothes *umbrella=[Clothes alloc];
            NSMutableArray *umbrellaFilterArray2=[self generateFilterArray:_umbrellaFilterArray];
            if([umbrellaFilterArray2 count]!=0){
                self.lackOfUmbrellas=NO;
                unsigned indexOfUmbrella =arc4random() % [umbrellaFilterArray2 count];
                umbrella=umbrellaFilterArray2[indexOfUmbrella];
                NSData *umbrellaImageData=umbrella.image;
                self.PickedUmbrella.image=[UIImage imageWithData:umbrellaImageData];
            }else{
                self.lackOfUmbrellas=YES;
            }
        }
        if (_needGlove) {
            Clothes *glove=[Clothes alloc];
            NSMutableArray *gloveFilterArray2=[self generateFilterArray:_gloveFilterArray];
            if([gloveFilterArray2 count]!=0){
                self.lackOfGloves=NO;
                unsigned indexOfGlove =arc4random() % [gloveFilterArray2 count];
                glove=gloveFilterArray2[indexOfGlove];
                NSData *gloveImageData=glove.image;
                self.PickedGlove.image=[UIImage imageWithData:gloveImageData];
            }else{
                self.lackOfGloves=YES;
            }
        }

    }
       //  indexOfClothes =arc4random() % [clothesFilterArray2 count];
       //  indexOfPants =arc4random() % [pantsFilterArray2 count];
       //  indexOfShoes =arc4random() % [shoesFilterArray2 count];
        
        
       // if([self.purpose isEqualToString:@"Formal Occasion"]){
          //  cloth=clothesFilterArray2[indexOfClothes];
        //    NSMutableArray *sameColorPants=[[NSMutableArray alloc]init];
//                for(Clothes *possibleClothes in pantsFilterArray2){
//                    if ([possibleClothes.color isEqualToString:cloth.color]) {
//                        [sameColorPants addObject:possibleClothes];
//                    }
//                }
//            indexOfPants=arc4random() % [sameColorPants count];
//            pant=sameColorPants[indexOfPants];
//            shoes=shoesFilterArray2[indexOfShoes];
//            
//        }else{
          //  cloth=clothesFilterArray2[indexOfClothes];
          //  pant=pantsFilterArray2[indexOfPants];
          //  shoes=shoesFilterArray2[indexOfShoes];
            
    
      //  NSData *clothesImageData= cloth.image;
//        NSData *pantsImageData=pant.image;
     //   NSData *shoesImageData=shoes.image;
        
    //    self.PickedClothes.image=[UIImage imageWithData:clothesImageData];
//        self.PickedPants.image=[UIImage imageWithData:pantsImageData];
//        self.PickedShoes.image=[UIImage imageWithData:shoesImageData];
        
           //    NSLog(@"%@",cloth.type);
    
    _cnt++;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"%@",self.purpose);
   // self.tabBarController.tabBar.hidden=NO;
  //  self.navigationController.navigationBar.alpha=1;
    _cnt=0;
    [self showSelection];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)PickClothes:(id)sender {
    [self showSelection];
    if (self.lackOfClothes || (self.lackOfGloves && _needGlove) || self.lackOfPants || self.lackOfShoes || (self.lackOfUmbrellas && _needUmbrella)) {
        NSString *clothes=[[NSString alloc]init];
        if(self.lackOfClothes) {clothes=[_shouldPickClothes stringByAppendingString:@" Clothes,"];}else{ clothes=@"";}
        NSString *gloves=[[NSString alloc]init];
        if(self.lackOfGloves && _needGlove) {gloves=@"gloves,";}else{ gloves=@"";}
        NSString *pants=[[NSString alloc]init];
        if(self.lackOfPants ) {pants=[_shouldPickPants stringByAppendingString:@" Pants,"];}else{ pants=@"";}
        NSString *shoe=[[NSString alloc]init];
        if(self.lackOfShoes) {shoe=[_shouldPickShoes stringByAppendingString:@" Shoes  "];}else{ shoe=@"";}
        NSString *umbrellas=[[NSString alloc]init];
        if(self.lackOfUmbrellas && _needUmbrella) {umbrellas=@"umbrellas";}else{ umbrellas=@"";}
        NSString *errormessage=[[NSString alloc]initWithFormat:@"%@%@%@%@%@",clothes,gloves,pants,shoe,umbrellas];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Oops,Lack of" message:errormessage delegate:self cancelButtonTitle:@"Please add some" otherButtonTitles: nil];
        [alert show];
    }
      //[self.PickedClothes setImage:[UIImage imageWithData:imageData]];
}

- (IBAction)confirmChoice:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Want Choose?" message:@"make a decision" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
//    NSDate *now=[NSDate date];
//    if(!self.lackOfClothes){
//    _cloth.selectTime=now;
//    }
//    if(!self.lackOfPants){
//    _pant.selectTime=now;
//    }
//    if(!self.lackOfShoes){
//    _shoes.selectTime=now;
//    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%i",buttonIndex);
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
        { NSDate *now=[NSDate date];
            if(!self.lackOfClothes){
                _cloth.selectTime=now;
                _cloth.useTime=[NSNumber numberWithInt:1+[_cloth.useTime intValue]];
                NSLog(@"it is %i",[_cloth.useTime intValue]);
            }
            if(!self.lackOfPants){
                _pant.selectTime=now;
                 _pant.useTime=[NSNumber numberWithInt:1+[_pant.useTime intValue]];
            }
            if(!self.lackOfShoes){
                _shoes.selectTime=now;
                 _shoes.useTime=[NSNumber numberWithInt:1+[_shoes.useTime intValue]];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
    }
}

@end