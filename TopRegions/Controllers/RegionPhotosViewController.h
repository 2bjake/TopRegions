//
//  RegionPhotosViewController.h
//  TopRegions
//
//  Created by Foster, Jake on 9/26/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "PhotosTableViewController.h"
#import "Region.h"

@interface RegionPhotosViewController : PhotosTableViewController
@property (nonatomic) Region *region;
@end
