//
//  NameEditViewController.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/7/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clothes.h"
@protocol NameEditDelegate
-(void) editName:(NSString *)nameedited;
@end

@interface NameEditViewController : UIViewController
- (IBAction)editDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *name;
@property (strong,nonatomic) Clothes *cloth;
@property (weak,nonatomic) id<NameEditDelegate> delegate;
@end
