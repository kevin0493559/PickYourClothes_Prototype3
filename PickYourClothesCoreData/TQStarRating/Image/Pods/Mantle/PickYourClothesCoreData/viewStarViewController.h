//
//  viewStarViewController.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/7/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TQStarRatingView.h"
#import "Clothes.h"
@protocol viewStarViewDelegate
-(void) editCothesrate:(NSNumber *)rate;
@end

@interface viewStarViewController : UIViewController<StarRatingViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *ratelabel;
@property (weak,nonatomic) Clothes *cloth;
@property (weak,nonatomic) id<viewStarViewDelegate> delegate;
@end
