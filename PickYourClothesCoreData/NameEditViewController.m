//
//  NameEditViewController.m
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/7/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import "NameEditViewController.h"

@interface NameEditViewController ()

@end

@implementation NameEditViewController

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
    _name.text=_cloth.name;
    _name.layer.borderWidth=2;
    _name.layer.borderColor=(__bridge CGColorRef)([UIColor grayColor]);
    
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
            if (_name!=nil) {
                NSLog(@"2");
                
                [self.delegate editName:_name.text];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            break;
    }
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches] anyObject];
    if([_name isFirstResponder] && [touch view]!=_name){
        [_name resignFirstResponder];
    }else if ([_name isFirstResponder]){
        [_name resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}
- (IBAction)editDone:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Want Change" message:@"make a decision" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}
@end
