//
//  Photo.h
//  TopRegions
//
//  Created by Foster, Jake on 9/29/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Region;
@class Photographer;

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSManagedObject
@property (nonatomic) NSURL* fullSizeUrl;
@property (nonatomic) NSURL* thumbnailUrl;

//+ (Photo *)getPhotoWithFickrPhotoDictionary:(NSDictionary *)photoDict context:(NSManagedObjectContext *)context;
+ (Photo *)getOrCreatePhotoWithFlickrPhotoDictionary:(NSDictionary *)photoDict context:(NSManagedObjectContext *)context;
@end

NS_ASSUME_NONNULL_END

#import "Photo+CoreDataProperties.h"
