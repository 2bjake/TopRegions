//
//  RecentPhotosViewController.m
//  TopRegions
//
//  Created by Foster, Jake on 9/27/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "RecentPhotosViewController.h"
#import "RegionDatabaseAvailability.h"

@interface RecentPhotosViewController ()

@end

@implementation RecentPhotosViewController

-(void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserverForName:RegionDatabaseAvailabilityNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      self.managedObjectContext = note.userInfo[RegionDatabaseAvailabilityContext];
                                                  }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.parentViewController.title = @"Recent Photos";
}

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    _managedObjectContext = managedObjectContext;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate = [NSPredicate predicateWithFormat:@"lastViewed != nil"];
    request.fetchLimit = 50;
    
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"lastViewed" ascending:NO]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

@end
