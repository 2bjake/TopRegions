//
//  AppDelegate.m
//  TopRegions
//
//  Created by Foster, Jake on 9/28/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "AppDelegate.h"
#import "Region.h" //temp
#import "RegionDatabaseAvailability.h"

#define CORE_DATA_FILE @"TopRegionsModel"
#define REGION @"Region"

@interface AppDelegate ()
@property (nonatomic) UIManagedDocument *regionDatabaseDocument;
@property (nonatomic) NSManagedObjectContext *regionDatabaseContext;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self openCoreDataDocument];
    return YES;
}

- (void)openCoreDataDocument {
    NSURL *url = [self coreDataUrl];
    if (!self.regionDatabaseDocument) {
        self.regionDatabaseDocument = [[UIManagedDocument alloc] initWithFileURL:url];
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
        [self.regionDatabaseDocument openWithCompletionHandler:^(BOOL success) {
            if (success) {
                [self regionDatabaseDocumentReady];
            } else {
                NSLog(@"couldn't open the document at %@", url);
            }
        }];
    } else {
        [self.regionDatabaseDocument saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                [self regionDatabaseDocumentReady];
            } else {
                NSLog(@"couldn't create the document at %@", url);
            }
        }];
    }
}

- (void)regionDatabaseDocumentReady {
    if (self.regionDatabaseDocument.documentState == UIDocumentStateNormal) {
        self.regionDatabaseContext = self.regionDatabaseDocument.managedObjectContext;
        [self populateRegionDatabase];
    } else {
        NSLog(@"document at %@ is not ready", self.regionDatabaseDocument.fileURL);
    }
}

- (void)setRegionDatabaseContext:(NSManagedObjectContext *)regionDatabaseContext {
    _regionDatabaseContext = regionDatabaseContext;
    NSDictionary *userInfo = self.regionDatabaseContext ? @{ RegionDatabaseAvailabilityContext : self.regionDatabaseContext} : nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:RegionDatabaseAvailabilityNotification
                                                        object:self
                                                      userInfo:userInfo];
}

- (void)populateRegionDatabase { //this is temp
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:REGION];
    request.fetchBatchSize = 20;
    request.predicate = nil;
    NSArray *regions = [self.regionDatabaseContext executeFetchRequest:request error:NULL];
    if ([regions count] == 0) {
        Region *region = [NSEntityDescription insertNewObjectForEntityForName:REGION inManagedObjectContext:self.regionDatabaseContext];
        region.unique = @"1";
        region.name = @"Hello";
        
        region = [NSEntityDescription insertNewObjectForEntityForName:REGION inManagedObjectContext:self.regionDatabaseContext];
        region.unique = @"2";
        region.name = @"World";
    }
}

- (NSURL *) coreDataUrl {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    return [documentsDirectory URLByAppendingPathComponent:CORE_DATA_FILE];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
