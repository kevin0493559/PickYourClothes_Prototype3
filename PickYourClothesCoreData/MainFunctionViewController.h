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
@property (strong, nonatomic) IBOutlet UIButton *PickedClothes;
@property (strong, nonatomic) IBOutlet UIButton *PickedPants;
@property (strong, nonatomic) IBOutlet UIButton *PickedShoes;
@property (strong, nonatomic) IBOutlet UIButton *PickedUmbrella;
@property (strong, nonatomic) IBOutlet UIButton *PickedGlove;
- (IBAction)PickClothes:(id)sender;
- (IBAction)confirmChoice:(id)sender;
- (IBAction)changeClothes:(id)sender;
- (IBAction)changePants:(id)sender;
- (IBAction)changeShoes:(id)sender;
- (IBAction)changeGloves:(id)sender;
- (IBAction)changeUmbrellas:(id)sender;

@end
