//
//  PhotosTableViewController.m
//  TopRegions
//
//  Created by Foster, Jake on 9/26/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "PhotosTableViewController.h"
#import "PhotoScrollViewController.h"
#import "FlickrFetcher.h"

NSString * const UNKNOWN = @"Unknown";

@interface PhotosTableViewController ()

@end

@implementation PhotosTableViewController

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
//        psvc.photoUrl = photoInfo.url;
//        [PhotosTableViewController addToRecentsPhotoInfo:photoInfo];
    }
}

@end