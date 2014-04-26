//
//  ShowDetailViewController.m
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/6/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import "ShowDetailViewController.h"

@interface ShowDetailViewController ()

@end

@implementation ShowDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)configure
{
    if (self.clothDetailID) {
        Clothes *cloth = (Clothes *)[kAppDelegate.managedObjectContext
                                       objectWithID:self.clothDetailID];
        
        
        _name.text=cloth.name;
        _brand.text=cloth.brand;
        NSData *image=cloth.image;
        _imageview.image=[UIImage imageWithData:image];
        _series.text=cloth.brandseries;
        _describe.text=cloth.describe;
        _useTime.text=[NSString stringWithFormat:@"%i",[cloth.useTime intValue]];
        TQStarRatingView *starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(50, 250, 150, 25)
                                                                      numberOfStar:5];
        [starRatingView setScore:([cloth.rate floatValue]/5) withAnimation:NO];
        //starRatingView.delegate = self;
        starRatingView.userInteractionEnabled=NO;
        [self.view addSubview:starRatingView];
//        UIView *newview=[[UIView alloc]initWithFrame:self.view.frame];
//        newview.userInteractionEnabled=NO;
//        [self.view addSubview:newview];
    }
}

#pragma segue
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"editdetail"]) {
        
        EditDetailTableViewController *detailedit=(EditDetailTableViewController *)[segue destinationViewController];
        [detailedit setEditclothID:self.clothDetailID];
        [detailedit setDelegate:self];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configure];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)clothesEdit:(Clothes *)clothedit
{   
    [self setClothDetailID:[clothedit objectID]];
    [self configure];
    
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

@end
