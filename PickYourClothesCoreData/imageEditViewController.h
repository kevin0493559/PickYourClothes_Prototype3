//
//  imageEditViewController.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/7/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clothes.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "DXAlertView.h"
@protocol imageEditViewDelegate
-(void) changeImage:(NSData *) image;
@end
@interface imageEditViewController : UIViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
@property BOOL newMedia;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePic:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong ,nonatomic) Clothes *cloth;
//@property (strong,nonatomic) NSManagedObjectID clothId;

- (IBAction)done:(id)sender;

@property (weak,nonatomic) id<imageEditViewDelegate> delegate;
@end
