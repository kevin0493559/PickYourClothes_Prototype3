//
//  viewStarViewController.m
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/7/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import "viewStarViewController.h"

@interface viewStarViewController ()

@end

@implementation viewStarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    TQStarRatingView *starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(30, 200, 250, 50)
                                                                  numberOfStar:5];
    [starRatingView setScore:([_cloth.rate floatValue])/5 withAnimation:YES];
    
    starRatingView.delegate = self;
    [self.view addSubview:starRatingView];
    _ratelabel.text=[NSString stringWithFormat:@"Cloth rate:%0.2f",[_cloth.rate floatValue]];
}
-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    self.ratelabel.text = [NSString stringWithFormat:@"Cloth rate:%0.2f",(score * 5) ];
    [self.delegate editCothesrate:[NSNumber numberWithFloat:(score*5)]];
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

@end
