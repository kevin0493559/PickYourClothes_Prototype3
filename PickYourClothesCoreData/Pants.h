//
//  Pants.h
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/5/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Pants : NSManagedObject

@property (nonatomic, retain) NSString * style;
@property (nonatomic, retain) NSString * usage;
@property (nonatomic, retain) NSNumber * length;
@property (nonatomic, retain) NSNumber * uniform;

@end
