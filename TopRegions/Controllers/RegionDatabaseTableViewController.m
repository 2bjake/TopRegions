//
//  RegionDatabaseTableViewController.m
//  TopRegions
//
//  Created by Foster, Jake on 9/28/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "RegionDatabaseTableViewController.h"
#import "RegionDatabaseAvailability.h"

@interface RegionDatabaseTableViewController ()

@end

@implementation RegionDatabaseTableViewController

-(void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserverForName:RegionDatabaseAvailabilityNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      self.managedObjectContext = note.userInfo[RegionDatabaseAvailabilityContext];
                                                  }];
}

@end
