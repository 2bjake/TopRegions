//
//  Region+CoreDataProperties.h
//  TopRegions
//
//  Created by Foster, Jake on 9/29/16.
//  Copyright © 2016 Amazon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Region.h"

NS_ASSUME_NONNULL_BEGIN

@interface Region (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *photographerCount;
@property (nullable, nonatomic, retain) NSSet<Photo *> *photos;
@property (nullable, nonatomic, retain) NSSet<Photographer *> *photographers;

@end

@interface Region (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet<Photo *> *)values;
- (void)removePhotos:(NSSet<Photo *> *)values;

- (void)addPhotographersObject:(Photographer *)value;
- (void)removePhotographersObject:(Photographer *)value;
- (void)addPhotographers:(NSSet<Photographer *> *)values;
- (void)removePhotographers:(NSSet<Photographer *> *)values;

@end

NS_ASSUME_NONNULL_END
