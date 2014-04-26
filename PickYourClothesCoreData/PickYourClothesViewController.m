//
//  PickYourClothesViewController.m
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/5/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import "PickYourClothesViewController.h"

@interface PickYourClothesViewController ()

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
}
- (void)viewDidLoad
{
    [super viewDidLoad];
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
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"purpose"]&&[self.gooutPurpose.text length]==0) {
        return NO;
    }
    
    else{return YES;}
    
}
@end
