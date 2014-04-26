//
//  DescribeEditViewController.m
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/7/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import "DescribeEditViewController.h"

@interface DescribeEditViewController ()

@end

@implementation DescribeEditViewController

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
    _decribe.text=_clothes.describe;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%i",buttonIndex);
    switch (buttonIndex) {
        case 0:
            [self.navigationController popViewControllerAnimated:YES];
            break;
            
        case 1:
           
                
                [self.delegate editDescirbe:_decribe.text];
                [self.navigationController popViewControllerAnimated:YES];
            
            
            break;
    }
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches] anyObject];
    if([_decribe isFirstResponder] && [touch view]!=_decribe){
        [_decribe resignFirstResponder];
    }else if ([_decribe isFirstResponder]){
        [_decribe resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}


- (IBAction)Done:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Want Change" message:@"make a decision" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}
@end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



