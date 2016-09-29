//
//  Photographer.m
//  TopRegions
//
//  Created by Foster, Jake on 9/29/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "Photographer.h"

#define PHOTOGRAPHER @"Photographer"

@implementation Photographer

+ (Photographer *)getPhotographerWithName:(NSString *)name context:(NSManagedObjectContext *)context {
    Photographer *photographer = nil;

    NSError *error = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:PHOTOGRAPHER];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSArray *results = [context executeFetchRequest:request error:&error];

    if (!results) {
        NSLog(@"Error fetching photographer: %@", error);
    } else if ([results count] > 1) {
        NSLog(@"Error: found multiple photographers with same name %@", name);
    } else if ([results count] == 1){
        photographer = results.firstObject;
    }
    return photographer;
}

+ (Photographer *)getOrCreatePhotographerWithName:(NSString *)name context:(NSManagedObjectContext *)context {
    Photographer *photographer = [Photographer getPhotographerWithName:name context:context];
    if (photographer) {
        return photographer;
    } // else create it
    
    photographer = [NSEntityDescription insertNewObjectForEntityForName:PHOTOGRAPHER inManagedObjectContext:context];
    photographer.name = name;
    return photographer;
}

@end
