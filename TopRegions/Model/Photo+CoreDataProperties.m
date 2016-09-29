//
//  Photo+CoreDataProperties.m
//  TopRegions
//
//  Created by Foster, Jake on 9/29/16.
//  Copyright © 2016 Amazon. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Photo+CoreDataProperties.h"

@implementation Photo (CoreDataProperties)

@dynamic title;
@dynamic detail;
@dynamic thumbnail;
@dynamic fullSizeUrlString;
@dynamic unique;
@dynamic thumbnailUrlString;
@dynamic placeId;
@dynamic owner;
@dynamic lastViewed;
@dynamic region;

@end
