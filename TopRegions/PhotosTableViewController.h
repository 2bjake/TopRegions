//
//  PhotosTableViewController.h
//  TopRegions
//
//  Created by Foster, Jake on 9/26/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionDatabaseTableViewController.h"

@interface PhotosTableViewController : RegionDatabaseTableViewController
@property (strong, nonatomic) IBOutlet UIRefreshControl *spinner;
@end
