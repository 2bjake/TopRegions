//
//  TopRegionsTableViewController.m
//  TopRegions
//
//  Created by Foster, Jake on 9/23/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "TopRegionsTableViewController.h"
#import "FlickrFetcher.h"
#import "RegionPhotosViewController.h"

@interface TopRegionsTableViewController ()
@property (strong, nonatomic) IBOutlet UIRefreshControl *spinner;
@end

@implementation TopRegionsTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.parentViewController.title = @"Top Regions";
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Region Cell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if (indexPath && [segue.identifier isEqualToString:@"showRegionPhotos"] && [segue.destinationViewController isKindOfClass:[RegionPhotosViewController class]]) {
        //RegionPhotosViewController *rpvc = (RegionPhotosViewController *)segue.destinationViewController;
        //TODO: set region
    }
}

@end
