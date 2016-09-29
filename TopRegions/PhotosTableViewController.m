//
//  PhotosTableViewController.m
//  TopRegions
//
//  Created by Foster, Jake on 9/26/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "PhotosTableViewController.h"
//#import "PhotoInfo.h"
#import "PhotoScrollViewController.h"
#import "FlickrFetcher.h"

NSString * const UNKNOWN = @"Unknown";

@interface PhotosTableViewController ()

@end

@implementation PhotosTableViewController
//@synthesize photoInfos = _photoInfos;

- (IBAction)refreshData:(UIRefreshControl *)sender {
    [self fetchPhotoData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchPhotoData];
}

/*
- (NSArray *)photoInfos {
    if (!_photoInfos) _photoInfos = [[NSArray alloc] init];
    return _photoInfos;
}

- (void)setPhotoInfos:(NSArray *)photoInfos {
    _photoInfos = photoInfos;
    [self.tableView reloadData];
    [self.spinner endRefreshing];
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.photoInfos.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo Cell" forIndexPath:indexPath];
    return cell;
}

- (void)fetchPhotoData {
    // abstract
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if (indexPath && [segue.identifier isEqualToString:@"showPhoto"] && [segue.destinationViewController isKindOfClass:[PhotoScrollViewController class]]) {
        PhotoScrollViewController *psvc = segue.destinationViewController;
        psvc.title = ((UITableViewCell *)sender).textLabel.text;
//        PhotoInfo *photoInfo = (PhotoInfo *)self.photoInfos[indexPath.row];
//        psvc.photoUrl = photoInfo.url;
//        [PhotosTableViewController addToRecentsPhotoInfo:photoInfo];
    }
}

@end