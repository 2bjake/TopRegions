//
//  Region.h
//  TopRegions
//
//  Created by Foster, Jake on 9/28/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;
@class Photographer;

NS_ASSUME_NONNULL_BEGIN

@interface Region : NSManagedObject
+ (Region *)getOrCreateRegionWithName:(NSString *)name context:(NSManagedObjectContext *)context;
@end

NS_ASSUME_NONNULL_END

#import "Region+CoreDataProperties.h"
