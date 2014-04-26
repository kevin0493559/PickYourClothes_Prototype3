//
//  MainFunctionViewController.h
//  PickYourClothesCoreData
//
//  Created by Rui Yao on 4/18/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clothes.h"
@interface MainFunctionViewController : UIViewController<NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong,nonatomic) NSFetchedResultsController *fetchrearch;
@property NSString *purpose;
@property (strong, nonatomic) IBOutlet UIImageView *PickedClothes;
@property (strong, nonatomic) IBOutlet UIImageView *PickedPants;
@property (strong, nonatomic) IBOutlet UIImageView *PickedShoes;
@property (strong, nonatomic) IBOutlet UIImageView *PickedUmbrella;
@property (strong, nonatomic) IBOutlet UIImageView *PickedGlove;
- (IBAction)PickClothes:(id)sender;
- (IBAction)confirmChoice:(id)sender;

@end
