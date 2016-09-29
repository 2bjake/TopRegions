//
//  Region.m
//  TopRegions
//
//  Created by Foster, Jake on 9/28/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "Region.h"

#define REGION @"Region"

@implementation Region

+ (Region *)getRegionWithName:(NSString *)name context:(NSManagedObjectContext *)context {
    Region *region = nil;

    NSError *error = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:REGION];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSArray *results = [context executeFetchRequest:request error:&error];

    if (!results) {
        NSLog(@"Error fetching region: %@", error);
    } else if ([results count] > 1) {
        NSLog(@"Error: found multiple regions with same name %@", name);
    } else if ([results count] == 1) {
        region = results.firstObject;
    }
    return region;
}

+ (Region *)getOrCreateRegionWithName:(NSString *)name context:(NSManagedObjectContext *)context {
    Region *region = [Region getRegionWithName:name context:context];
    if (region) {
        return region;
    } // else create it
    
    region = [NSEntityDescription insertNewObjectForEntityForName:REGION inManagedObjectContext:context];
    region.name = name;
    return region;
}

@end
