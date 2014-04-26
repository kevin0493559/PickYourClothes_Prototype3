//
//  ShowDetailViewController.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/6/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clothes.h"
#import "PickYourClothesCoreDataAppDelegate.h"
#import "EditDetailTableViewController.h"
#import "TQStarRatingView.h"

@interface ShowDetailViewController : UIViewController<EditDetailTableDelegate,StarRatingViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *brand;

@property (weak, nonatomic) IBOutlet UILabel *useTime;
@property (weak, nonatomic) IBOutlet UIView *starView;

@property (strong, nonatomic) NSManagedObjectID *clothDetailID;
@property (weak, nonatomic) IBOutlet UITextView *describe;

@property (weak, nonatomic) IBOutlet UILabel *series;
@property(strong,nonatomic) Clothes* clothes;
@end
