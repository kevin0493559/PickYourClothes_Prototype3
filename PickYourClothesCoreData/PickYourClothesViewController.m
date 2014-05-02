//
//  PickYourClothesViewController.m
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/5/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import "PickYourClothesViewController.h"

@interface PickYourClothesViewController ()
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong,nonatomic) NSFetchedResultsController *fetchrearch;
@property (strong,nonatomic) NSArray *clothesArray;
@property (nonatomic) Clothes *recentCloth1;
@property (nonatomic) Clothes *recentCloth2;
@end

@implementation PickYourClothesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated{
    self.gooutPurpose.text=@"";
    [self showRecent];
}
-(void) showRecent{
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
    
    if([_clothesArray count]!=0){
    NSMutableArray *clothesFilterArray=[[NSMutableArray alloc]init];
    for(Clothes *cloth in _clothesArray){
        NSString *check=[self showTime:cloth.selectTime];
        BOOL a=[check length]==0;
        if ([cloth.kindOf isEqualToString:@"Jacketing"]&&!a) {
            [clothesFilterArray addObject:cloth];
        }
    }
        if([clothesFilterArray count]>0){
            NSArray *sortedArray=[self compareDate:clothesFilterArray];
            NSInteger i=[sortedArray count];
            _recentCloth1=sortedArray[i-1];
            NSData *clothImage1=_recentCloth1.image;
            [self.showRecent1 setBackgroundImage:[UIImage imageWithData:clothImage1] forState:UIControlStateNormal];
            if([clothesFilterArray count]>1){
                _recentCloth2=sortedArray[i-2];
                NSData *clothImage2=_recentCloth2.image;
                [self.showRecent2 setBackgroundImage:[UIImage imageWithData:clothImage2] forState:UIControlStateNormal];
            }else{
                [self.showRecent2 setBackgroundImage:nil forState:UIControlStateNormal];
                self.showRecent2.enabled=NO;
            }
        }else{
            [self.showRecent1 setBackgroundImage:nil forState:UIControlStateNormal];
            self.showRecent1.enabled=NO;
        }
    }else{
        self.showRecent1.enabled=NO;
        self.showRecent2.enabled=NO;
        [self.showRecent1 setBackgroundImage:nil forState:UIControlStateNormal];
        [self.showRecent2 setBackgroundImage:nil forState:UIControlStateNormal];
    }
}
-(NSString *) showTime:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
-(NSArray *) compareDate:(NSArray *)originalArray{
    NSArray *sortedArray = [originalArray sortedArrayUsingComparator:^(Clothes *obj1, Clothes *obj2){
        NSDate *date1 = obj1.selectTime;
        NSDate *date2 = obj2.selectTime;
        return [date1 compare:date2];
    }];
    return sortedArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self showRecent];
    self.start.layer.cornerRadius=20;
    NSArray *items = [NSArray arrayWithObjects:@"Exercise,Gym,Sports", @"Formal Occasion", @"Others", nil];
    self.gooutPurpose.items = items;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"purpose"]) {
        MainFunctionViewController *mainfunc=[segue destinationViewController];
        mainfunc.purpose= self.gooutPurpose.text;
    }
    
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

- (IBAction)startPick:(id)sender {
    if([self.gooutPurpose.text length]==0){
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"Please enter a purpose" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)chooseRecent:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Want Choose Again?" message:@"make a decision" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
    alert.tag=1;
}

- (IBAction)chooseRecent2:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Want Choose Again?" message:@"make a decision" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
    alert.tag=2;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%i",buttonIndex);
    if([alertView tag]==1)
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
        { NSDate *now=[NSDate date];
           
                [self save:_recentCloth1 atTime:now];
            NSLog(@"this is tag 1");
        }
            break;
    }else{
        switch (buttonIndex) {
            case 0:
                break;
            case 1:
            { NSDate *now=[NSDate date];
                
                [self save:_recentCloth2 atTime:now];
                [self showRecent];
                 NSLog(@"this is tag 2");
            }
                break;
    }
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
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"purpose"]&&[self.gooutPurpose.text length]==0) {
        return NO;
    }
    
    else{return YES;}
    
}
@end
