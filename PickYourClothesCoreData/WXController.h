//
//  WXController.h
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/11/13.
//  Copyright (c) 2013 Ryan Nystrom. All rights reserved.
//

@import UIKit;

@interface WXController : UIViewController
<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,UITabBarControllerDelegate>
@property (nonatomic) UILabel *temperatureLabel;
@property (nonatomic) UILabel *hiloLabel;
@property (nonatomic) UILabel *cityLabel;
@property (nonatomic) UILabel *conditionsLabel;
@property (nonatomic) UIImageView *iconView;
@end
