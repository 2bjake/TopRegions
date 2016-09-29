//
//  Photographer+CoreDataProperties.h
//  TopRegions
//
//  Created by Foster, Jake on 9/29/16.
//  Copyright © 2016 Amazon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photographer.h"

NS_ASSUME_NONNULL_BEGIN

@interface Photographer (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photo;
@property (nullable, nonatomic, retain) NSSet<Region *> *region;

@end

@interface Photographer (CoreDataGeneratedAccessors)

- (void)addPhotoObject:(Photo *)value;
- (void)removePhotoObject:(Photo *)value;
- (void)addPhoto:(NSSet<Photo *> *)values;
- (void)removePhoto:(NSSet<Photo *> *)values;

- (void)addRegionObject:(Region *)value;
- (void)removeRegionObject:(Region *)value;
- (void)addRegion:(NSSet<Region *> *)values;
- (void)removeRegion:(NSSet<Region *> *)values;

@end

NS_ASSUME_NONNULL_END
