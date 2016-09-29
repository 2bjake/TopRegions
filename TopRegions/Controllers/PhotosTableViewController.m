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
#import "Photo.h"

NSString * const UNKNOWN = @"Unknown";

@interface PhotosTableViewController ()

@end

@implementation PhotosTableViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo Cell" forIndexPath:indexPath];
    Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if ([photo.detail length] == 0) {
        cell.detailTextLabel.text = @"";
    } else {
        cell.detailTextLabel.text = photo.detail;
    }
    
    if([photo.title length] == 0) {
        if ([cell.detailTextLabel.text length] == 0) {
            cell.textLabel.text = UNKNOWN;
        } else {
            cell.textLabel.text = cell.detailTextLabel.text;
            cell.detailTextLabel.text = @"";
        }
    } else {
        cell.textLabel.text = photo.title;
    }
    
    if (photo.thumbnail) {
        cell.imageView.image = [UIImage imageWithData:photo.thumbnail];
    } else {
        cell.imageView.image = nil;
    }
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if (indexPath && [segue.identifier isEqualToString:@"showPhoto"] && [segue.destinationViewController isKindOfClass:[PhotoScrollViewController class]]) {
        Photo *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];

        PhotoScrollViewController *psvc = segue.destinationViewController;
        psvc.title = ((UITableViewCell *)sender).textLabel.text;
        psvc.photoUrl = photo.fullSizeUrl;
        photo.lastViewed = [NSDate date];
        //TODO: get thumbnail and set into Photo object
        if (!photo.thumbnail) {
            [self fetchThumbnailForPhoto:photo];
        }
    }
}

- (void)fetchThumbnailForPhoto:(Photo *)photo {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:photo.thumbnailUrl];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDownloadTask *task =
    [session downloadTaskWithRequest:request
                   completionHandler:^(NSURL * _Nullable localFile, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                       if (!error) {
                           NSData *data = [NSData dataWithContentsOfURL:localFile options:0 error:&error];
                           if (!error) {
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   photo.thumbnail = data;
                               });
                           }
                       }
                       
                       if (error) {
                           NSLog(@"%@", error); //TODO: this is a bug, new image won't be loaded
                       }
                   }];
    [task resume];
}

@end