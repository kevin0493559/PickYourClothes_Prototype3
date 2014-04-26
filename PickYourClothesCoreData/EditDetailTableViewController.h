//
//  EditDetailTableViewController.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/6/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clothes.h"
#import <QuartzCore/QuartzCore.h>
#import "imageEditViewController.h"
#import "NameEditViewController.h"
#import "BrandSeriesViewController.h"
#import "DescribeEditViewController.h"
#import "viewStarViewController.h"
@protocol EditDetailTableDelegate

-(void)clothesEdit:(Clothes *)clothedit;

@end

@interface EditDetailTableViewController : UITableViewController<NSFetchedResultsControllerDelegate,imageEditViewDelegate,NameEditDelegate,BrandSeriesDelegat,DescribeEditViewDelegate,UIAlertViewDelegate,viewStarViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *buttondelete;
@property (weak, nonatomic) IBOutlet UIView *viewStar;
@property (weak, nonatomic) IBOutlet UILabel *clothesrate;

- (IBAction)Save:(id)sender;

- (IBAction)deleteButton:(id)sender;

@property (nonatomic, strong) NSManagedObjectID *editclothID;

@property (weak, nonatomic) IBOutlet UILabel *entity;

@property (weak, nonatomic) IBOutlet UIImageView *image;
- (IBAction)imageSet:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *brandseries;
@property (weak, nonatomic) IBOutlet UILabel *brand;
@property (weak, nonatomic) IBOutlet UITextView *textfield;

- (IBAction)switchlandry:(id)sender;





@property (nonatomic,weak) id<EditDetailTableDelegate> delegate;
@end
