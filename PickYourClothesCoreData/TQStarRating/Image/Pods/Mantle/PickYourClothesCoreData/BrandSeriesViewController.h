//
//  BrandSeriesViewController.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/7/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clothes.h"
@protocol BrandSeriesDelegat
-(void) editBrandSeries:(NSString *)brandseries;
@end
@interface BrandSeriesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *brandseries;
- (IBAction)Done:(id)sender;

@property (strong,nonatomic) Clothes *cloth;
@property (weak,nonatomic) id<BrandSeriesDelegat> delegate;
@end
