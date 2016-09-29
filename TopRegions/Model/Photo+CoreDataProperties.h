//
//  Photo+CoreDataProperties.h
//  TopRegions
//
//  Created by Foster, Jake on 9/29/16.
//  Copyright © 2016 Amazon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *detail;
@property (nullable, nonatomic, retain) NSData *thumbnail;
@property (nullable, nonatomic, retain) NSString *fullSizeUrlString;
@property (nullable, nonatomic, retain) NSString *unique;
@property (nullable, nonatomic, retain) NSString *thumbnailUrlString;
@property (nullable, nonatomic, retain) NSString *placeId;
@property (nullable, nonatomic, retain) NSString *owner;
@property (nullable, nonatomic, retain) NSDate *lastViewed;
@property (nullable, nonatomic, retain) Region *region;

@end

NS_ASSUME_NONNULL_END
