//
//  RegionDatabaseTableViewController.h
//  TopRegions
//
//  Created by Foster, Jake on 9/28/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface RegionDatabaseTableViewController : CoreDataTableViewController
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@end
