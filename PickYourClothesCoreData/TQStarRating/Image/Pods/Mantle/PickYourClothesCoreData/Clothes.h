//
//  Clothes.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/7/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class People;

@interface Clothes : NSManagedObject

@property (nonatomic, retain) NSDate * addTime;
@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSString * brandseries;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSString * describe;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSString * kindOf;
@property (nonatomic, retain) NSNumber * landry;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) NSNumber * useTime;
@property (nonatomic, retain) People *belong;

@end
