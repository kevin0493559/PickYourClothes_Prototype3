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
//@property (nonatomic, strong) NSManagedObjectID *clothID;
//@property (nonatomic, strong) NSManagedObjectID *pantID;
//@property (nonatomic, strong) NSManagedObjectID *shoeID;
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
    NSMutableArray *initialArray2=[[NSMutableArray alloc]init];
    for(Clothes *cloth in initialArray){
        if ([cloth.useTime intValue]<5) {
            //NSLog(@"this is %i",[cloth.useTime intValue]);
           [initialArray2 addObject:cloth];
        }
    }
    NSMutableArray *filterArray=[[NSMutableArray alloc]init];
    if([initialArray2 count]!=0){
    int count=0;
    for (int i=0; i<[initialArray2 count]; i++) {
        Clothes *cloth=initialArray2[i];
        for (int j=0; j<cloth.rate.intValue+1; j++) {
            filterArray[count]=initialArray2[i];
            count++;
        }
    }
    }
    return filterArray;
}
-(void)showSelectionOfClothes{
    _cloth=[Clothes alloc];
    unsigned indexOfClothes;
    NSMutableArray *clothesFilterArray2=[self generateFilterArray:_clothesFilterArray];
    if ([clothesFilterArray2 count]!=0) {
        self.lackOfClothes=NO;
        indexOfClothes =arc4random() % [clothesFilterArray2 count];
        _cloth=clothesFilterArray2[indexOfClothes];
        NSData *clothesImageData= _cloth.image;
        [self.PickedClothes setBackgroundImage:[UIImage imageWithData:clothesImageData] forState:UIControlStateNormal] ;
    }else{
        self.lackOfClothes=YES;
        self.PickedClothes.enabled=NO;
    }
}
-(void)showSelectionOfPants{
    _pant=[Clothes alloc];
    unsigned indexOfPants;
    NSMutableArray *pantsFilterArray2=[self generateFilterArray:_pantsFilterArray];
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
        [self.PickedPants setBackgroundImage:[UIImage imageWithData:pantsImageData] forState:UIControlStateNormal];
    }else{
        self.lackOfPants=YES;
        self.PickedPants.enabled=NO;
    }
}
-(void)showSelectionOfShoes{
    _shoes=[Clothes alloc];
    unsigned indexOfShoes;
    NSMutableArray *shoesFilterArray2=[self generateFilterArray:_shoesFilterArray];
    if ([shoesFilterArray2 count]!=0) {
        self.lackOfShoes=NO;
        indexOfShoes =arc4random() % [shoesFilterArray2 count];
        _shoes=shoesFilterArray2[indexOfShoes];
        NSData *shoesImageData=_shoes.image;
        [self.PickedShoes setBackgroundImage:[UIImage imageWithData:shoesImageData] forState:UIControlStateNormal];
    }else{
        self.lackOfShoes=YES;
        self.PickedShoes.enabled=NO;
    }
}
-(void)showSelectionOfUmbrella{
    Clothes *umbrella=[Clothes alloc];
    NSMutableArray *umbrellaFilterArray2=[self generateFilterArray:_umbrellaFilterArray];
    if([umbrellaFilterArray2 count]!=0){
        self.lackOfUmbrellas=NO;
        unsigned indexOfUmbrella =arc4random() % [umbrellaFilterArray2 count];
        umbrella=umbrellaFilterArray2[indexOfUmbrella];
        NSData *umbrellaImageData=umbrella.image;
        [self.PickedUmbrella setBackgroundImage:[UIImage imageWithData:umbrellaImageData] forState:UIControlStateNormal];
    }else{
        self.lackOfUmbrellas=YES;
        self.PickedUmbrella.enabled=NO;
    }
}
-(void)showSelectionOfGlove{
    Clothes *glove=[Clothes alloc];
    NSMutableArray *gloveFilterArray2=[self generateFilterArray:_gloveFilterArray];
    if([gloveFilterArray2 count]!=0){
        self.lackOfGloves=NO;
        unsigned indexOfGlove =arc4random() % [gloveFilterArray2 count];
        glove=gloveFilterArray2[indexOfGlove];
        NSData *gloveImageData=glove.image;
        [self.PickedGlove setBackgroundImage:[UIImage imageWithData:gloveImageData] forState:UIControlStateNormal];
    }else{
        self.lackOfGloves=YES;
        self.PickedGlove.enabled=NO;
    }
}
-(void)showOriginal{
    [self.PickedClothes setBackgroundImage:[UIImage imageNamed:@"originalShow_jacket"] forState:UIControlStateNormal];
    [self.PickedPants setBackgroundImage:[UIImage imageNamed:@"originalShow_pant"] forState:UIControlStateNormal];
    [self.PickedShoes setBackgroundImage:[UIImage imageNamed:@"originalShow_shoes"] forState:UIControlStateNormal];
    [self.PickedUmbrella setBackgroundImage:[UIImage imageNamed:@"originalShow_umbrella"] forState:UIControlStateNormal];
    [self.PickedGlove setBackgroundImage:[UIImage imageNamed:@"originalShow_glove"] forState:UIControlStateNormal];
}
-(void)showAllSelection{
    [self findClothes];
    if(_cnt!=0){
        [self showSelectionOfClothes];
        [self showSelectionOfPants];
        [self showSelectionOfShoes];
        if (_needUmbrella) {
            [self showSelectionOfUmbrella];
        }else{
            self.PickedUmbrella.enabled=NO;
        }
        if (_needGlove) {
            [self showSelectionOfGlove];
        }else{
            self.PickedGlove.enabled=NO;
        }
    }else{
        [self showOriginal];
    }
    _cnt++;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"%@",self.purpose);
   // self.tabBarController.tabBar.hidden=NO;
  //  self.navigationController.navigationBar.alpha=1;
    _cnt=0;
    [self showAllSelection];
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
    [self showAllSelection];
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

- (IBAction)changeClothes:(id)sender {
    [self showSelectionOfClothes];
}

- (IBAction)changePants:(id)sender {
    [self showSelectionOfPants];
}

- (IBAction)changeShoes:(id)sender {
    [self showSelectionOfShoes];
}

- (IBAction)changeGloves:(id)sender {
    if (_needGlove) {
        [self showSelectionOfGlove];
    }
}

- (IBAction)changeUmbrellas:(id)sender {
    if (_needUmbrella) {
        [self showSelectionOfUmbrella];
    }
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
                [self save:_cloth atTime:now];
            }
            if(!self.lackOfPants){
                [self save:_pant atTime:now];
            }
            if(!self.lackOfShoes){
                [self save:_shoes atTime:now];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
            break;
    }
}
-(void)save:(Clothes *)cloth atTime:(NSDate *)date{
    NSManagedObjectID *clothID=[[NSManagedObjectID alloc]init];
    clothID=[cloth objectID];
    NSManagedObjectContext *moc=[kAppDelegate managedObjectContext];
    NSManagedObject *object=[kAppDelegate.managedObjectContext objectWithID:clothID];
    [object setValue:date forKeyPath:@"selectTime"];
    [object setValue:[NSNumber numberWithInt:1+[cloth.useTime intValue]] forKeyPath:@"useTime"];
    NSError *error;
    [moc save:&error];
}
@end
