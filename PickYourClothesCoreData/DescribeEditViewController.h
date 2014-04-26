//
//  DescribeEditViewController.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/7/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clothes.h"
@protocol DescribeEditViewDelegate
-(void) editDescirbe:(NSString *)descibeedit;
@end
@interface DescribeEditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *decribe;
- (IBAction)Done:(id)sender;
@property (weak,nonatomic) id<DescribeEditViewDelegate> delegate;
@property (strong,nonatomic) Clothes *clothes;
@end
