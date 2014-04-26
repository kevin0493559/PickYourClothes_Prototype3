//
//  KindOfViewController.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/5/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"
#import "DXAlertView.h"
@interface KindOfViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource,UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UIPickerView *picker;
- (IBAction)Select:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttomLook;
@property (weak, nonatomic) IBOutlet UIImageView *imageout;

@end
