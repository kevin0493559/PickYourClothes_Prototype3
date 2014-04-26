//
//  BrandSeriesViewController.m
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/7/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import "BrandSeriesViewController.h"

@interface BrandSeriesViewController ()

@end

@implementation BrandSeriesViewController

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
    _brandseries.text=_cloth.brandseries;
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%i",buttonIndex);
    switch (buttonIndex) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        case 1:
            if (_brandseries!=nil) {
                NSLog(@"2");
                
                [self.delegate editBrandSeries:_brandseries.text];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            break;
    }
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches] anyObject];
    if([_brandseries isFirstResponder] && [touch view]!=_brandseries){
        [_brandseries resignFirstResponder];
    }else if ([_brandseries isFirstResponder]){
        [_brandseries resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


- (IBAction)Done:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Want Change" message:@"make a decision" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}
@end
