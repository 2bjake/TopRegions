//
//  Photographer.h
//  TopRegions
//
//  Created by Foster, Jake on 9/29/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;
@class Region;

NS_ASSUME_NONNULL_BEGIN

@interface Photographer : NSManagedObject
+ (Photographer *)getOrCreatePhotographerWithName:(NSString *)name context:(NSManagedObjectContext *)context;
@end

NS_ASSUME_NONNULL_END

#import "Photographer+CoreDataProperties.h"
