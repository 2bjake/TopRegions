//
//  RecentPhotosViewController.m
//  TopRegions
//
//  Created by Foster, Jake on 9/27/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "RecentPhotosViewController.h"

@interface RecentPhotosViewController ()

@end

@implementation RecentPhotosViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.parentViewController.title = @"Recent Photos";
}

- (void)fetchPhotoData {
}

@end
