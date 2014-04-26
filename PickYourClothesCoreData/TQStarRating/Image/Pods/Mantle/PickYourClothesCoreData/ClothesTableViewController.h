//
//  ClothesTableViewController.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/6/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickYourClothesCoreDataTableViewCell.h"
#import "Clothes.h"
#import "ShowDetailViewController.h"

@interface ClothesTableViewController : UITableViewController <NSFetchedResultsControllerDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong,nonatomic) NSFetchedResultsController *fetchrearch;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong,nonatomic) NSMutableArray *filtarray;
@property (strong,nonatomic) NSMutableArray *cloth;

@property (weak,nonatomic) NSString *name;
@property (weak,nonatomic) Clothes *clothpara;
@end
