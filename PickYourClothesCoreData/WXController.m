//
//  WXController.m
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/11/13.
//  Copyright (c) 2013 Ryan Nystrom. All rights reserved.
//

#import "WXController.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import "WXManager.h"

@interface WXController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurredImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat screenHeight;

//@property (nonatomic, strong) NSDateFormatter *hourlyFormatter;
//@property (nonatomic, strong) NSDateFormatter *dailyFormatter;

@end

@implementation WXController
//- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
//    [send]
//}

- (id)init {
    if (self = [super init]) {
            }
    return self;
}
//-(void) setNavigationBar{
//    self.navigationController.navigationBar.alpha=0;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   // self.navigationController.navigationBar.alpha=0.3;
  //  self.tabBarController.tabBar.hidden=YES;
    //[self setNavigationBar];
	self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIImage *background = [UIImage imageNamed:@"bg"];
    
    self.backgroundImageView = [[UIImageView alloc] initWithImage:background];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    
    self.blurredImageView = [[UIImageView alloc] init];
    self.blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blurredImageView.alpha = 0;
    [self.blurredImageView setImageToBlur:background blurRadius:10 completionBlock:nil];
    [self.view addSubview:self.blurredImageView];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.tableView.pagingEnabled = YES;
   
    [self.view addSubview:self.tableView];
    
    CGRect headerFrame = [UIScreen mainScreen].bounds;
    CGFloat inset = self.view.bounds.size.width/3.25;
    CGFloat temperatureHeight = 110;
    CGFloat hiloHeight = 40;
    CGFloat iconHeight = 80;
    CGRect hiloFrame = CGRectMake(inset, headerFrame.size.height - hiloHeight-150, self.view.bounds.size.width/2, hiloHeight);
    CGRect temperatureFrame = CGRectMake(inset, headerFrame.size.height - temperatureHeight - hiloHeight-150,self.view.bounds.size.width/2, temperatureHeight);
    CGRect iconFrame = CGRectMake(inset, temperatureFrame.origin.y - iconHeight, iconHeight, iconHeight);
    CGRect conditionsFrame = iconFrame;
    // make the conditions text a little smaller than the view
    // and to the right of our icon
    conditionsFrame.size.width = self.view.bounds.size.width/2;
    conditionsFrame.origin.x = iconFrame.origin.x + iconHeight + 10;
    
    UIView *header = [[UIView alloc] initWithFrame:headerFrame];
    header.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = header;
    
	// bottom left
    self.temperatureLabel = [[UILabel alloc] initWithFrame:temperatureFrame];
    self.temperatureLabel.backgroundColor = [UIColor clearColor];
    self.temperatureLabel.textColor = [UIColor whiteColor];
    self.temperatureLabel.text = @"0°";
    self.temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:100];
    [header addSubview:self.temperatureLabel];
    
    // bottom left
    self.hiloLabel = [[UILabel alloc] initWithFrame:hiloFrame];
    self.hiloLabel.backgroundColor = [UIColor clearColor];
    self.hiloLabel.textColor = [UIColor whiteColor];
    self.hiloLabel.text = @"0° / 0°";
    self.hiloLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];
    [header addSubview:self.hiloLabel];
    
    // top
    self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 30)];
    self.cityLabel.backgroundColor = [UIColor clearColor];
    self.cityLabel.textColor = [UIColor whiteColor];
    self.cityLabel.text = @"Loading...";
    self.cityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40];
    self.cityLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:self.cityLabel];
    
    self.conditionsLabel = [[UILabel alloc] initWithFrame:conditionsFrame];
    self.conditionsLabel.backgroundColor = [UIColor clearColor];
    self.conditionsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    self.conditionsLabel.textColor = [UIColor whiteColor];
    [header addSubview:self.conditionsLabel];
    
    // bottom left
    self.iconView = [[UIImageView alloc] initWithFrame:iconFrame];
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.iconView.backgroundColor = [UIColor clearColor];
    [header addSubview:self.iconView];
    
    [[RACObserve([WXManager sharedManager], currentCondition)
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(WXCondition *newCondition) {
         self.temperatureLabel.text = [NSString stringWithFormat:@"%.0f°",newCondition.temperature.floatValue];
         NSLog(@"current is %i",newCondition.temperature.intValue);
         self.conditionsLabel.text = [newCondition.condition capitalizedString];
         self.cityLabel.text = [newCondition.locationName capitalizedString];
         self.iconView.image = [UIImage imageNamed:[newCondition imageName]];
         
         NSString *backName=[[NSString alloc]init];
         if ([[newCondition imageName] isEqualToString:@"weather-clear" ] ){
             backName=@"sunny";
         }
                 if ([[newCondition imageName] isEqualToString:@"weather-mist" ] ){
             backName=@"mist";
         }
         if ([[newCondition imageName] isEqualToString:@"weather-rain-night" ] ||  [[newCondition imageName] isEqualToString:@"weather-rain" ] ||  [[newCondition imageName] isEqualToString:@"weather-shower" ] ){
             backName=@"rainy";
         }
         if ([[newCondition imageName] isEqualToString:@"weather-broken" ] ||  [[newCondition imageName] isEqualToString:@"weather-few" ] ||  [[newCondition imageName] isEqualToString:@"weather-scattered" ]){
             backName=@"cloudy";
         }
         if ([[newCondition imageName] isEqualToString:@"weather-moon" ] ){
             backName=@"clear_night";
         }
         if ([[newCondition imageName] isEqualToString:@"weather-few-night" ] ){
             backName=@"cloudynight";
         }
         if ([[newCondition imageName] isEqualToString:@"weather-snow" ] ){
             backName=@"snow";
         }
         if ([[newCondition imageName] isEqualToString:@"weather-tstorm" ] ){
             backName=@"storm";
         }
         UIImage *background = [UIImage imageNamed:backName];
         
         self.backgroundImageView.image =background;
         self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        
         self.blurredImageView.image=background;
         self.blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
         self.blurredImageView.alpha = 0;
         
         

         
     }];
    
    RAC(self.hiloLabel, text) = [[RACSignal combineLatest:@[
                                                       RACObserve([WXManager sharedManager], currentCondition.tempHigh),
                                                       RACObserve([WXManager sharedManager], currentCondition.tempLow)]
                                              reduce:^(NSNumber *hi, NSNumber *low) {
                                                  return [NSString  stringWithFormat:@"%.0f° / %.0f°",hi.floatValue,low.floatValue];
                                              }]
                            deliverOn:RACScheduler.mainThreadScheduler];
    
    [[RACObserve([WXManager sharedManager], hourlyForecast)
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(NSArray *newForecast) {
         [self.tableView reloadData];
     }];
    
    [[RACObserve([WXManager sharedManager], dailyForecast)
      deliverOn:RACScheduler.mainThreadScheduler]
     subscribeNext:^(NSArray *newForecast) {
         [self.tableView reloadData];
     }];
    
    [[WXManager sharedManager] findCurrentLocation];
}
-(void)viewWillAppear:(BOOL)animated{
    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    self.backgroundImageView.frame = bounds;
    self.blurredImageView.frame = bounds;
    self.tableView.frame = bounds;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
        return MIN([[WXManager sharedManager].hourlyForecast count], 6) + 1;
    }
    return MIN([[WXManager sharedManager].dailyForecast count], 6) + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self configureHeaderCell:cell title:@"Hourly Forecast"];
        }
        else {
            WXCondition *weather = [WXManager sharedManager].hourlyForecast[indexPath.row - 1];
            [self configureHourlyCell:cell weather:weather];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self configureHeaderCell:cell title:@"Daily Forecast"];
        }
        else {
            WXCondition *weather = [WXManager sharedManager].dailyForecast[indexPath.row - 1];
            [self configureDailyCell:cell weather:weather];
        }
    }
    
    return cell;
}

- (void)configureHeaderCell:(UITableViewCell *)cell title:(NSString *)title {
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = @"";
    cell.imageView.image = nil;
}

- (void)configureHourlyCell:(UITableViewCell *)cell weather:(WXCondition *)weather {
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    NSDateFormatter *hourlyFormatter=[[NSDateFormatter alloc]init];
    [hourlyFormatter setDateFormat:@"h a"];
    cell.textLabel.text = [hourlyFormatter stringFromDate:weather.date];
  //  NSLog(@"it is %@",[_hourlyFormatter stringFromDate:weather.date]);
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f°",weather.temperature.floatValue];
    cell.imageView.image = [UIImage imageNamed:[weather imageName]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)configureDailyCell:(UITableViewCell *)cell weather:(WXCondition *)weather {
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    NSDateFormatter *dailyFormatter=[[NSDateFormatter alloc]init];
    [dailyFormatter setDateFormat:@"EEEE"];
    cell.textLabel.text = [dailyFormatter stringFromDate:weather.date];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0f° / %.0f°",weather.tempHigh.floatValue,weather.tempLow.floatValue];
    cell.imageView.image = [UIImage imageNamed:[weather imageName]];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger cellCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    return self.screenHeight / (CGFloat)cellCount;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = scrollView.bounds.size.height;
    CGFloat position = MAX(scrollView.contentOffset.y, 0.0);
    CGFloat percent = MIN(position / height, 1.0);
    self.blurredImageView.alpha = percent;
}

@end
