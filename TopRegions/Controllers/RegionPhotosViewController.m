//
//  RegionPhotosViewController.m
//  TopRegions
//
//  Created by Foster, Jake on 9/26/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "RegionPhotosViewController.h"
#import "FlickrFetcher.h"

@interface RegionPhotosViewController ()
@end

@implementation RegionPhotosViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    NSManagedObjectContext *context = self.region.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"region = %@", self.region];
    request.sortDescriptors = @[];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

@end
