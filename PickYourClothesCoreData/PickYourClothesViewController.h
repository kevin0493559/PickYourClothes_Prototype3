//
//  PickYourClothesViewController.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/5/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainFunctionViewController.h"
#import "UICombox.h"
#import "Clothes.h"
@interface PickYourClothesViewController : UIViewController<NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *showRecent1;
@property (strong, nonatomic) IBOutlet UIButton *showRecent2;
@property (strong, nonatomic) IBOutlet UICombox *gooutPurpose;
@property (strong, nonatomic) IBOutlet UIButton *start;
@property (nonatomic) MainFunctionViewController *mainfunctioncontroller;
- (IBAction)startPick:(id)sender;
- (IBAction)chooseRecent:(id)sender;
- (IBAction)chooseRecent2:(id)sender;
@end
