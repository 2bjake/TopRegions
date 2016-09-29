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
#import "RegionDatabaseAvailability.h"
#import "Region.h"

@interface TopRegionsTableViewController ()
@property (strong, nonatomic) IBOutlet UIRefreshControl *spinner;
@end

@implementation TopRegionsTableViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.parentViewController.title = @"Top Regions";
}

-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    [super setManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Region"];
    request.predicate = nil;
    //TODO: add sort descriptor for number of photographers
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                cacheName:nil];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Region Cell" forIndexPath:indexPath];
    Region *region = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = region.name;
    cell.detailTextLabel.text = @"yay";
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
