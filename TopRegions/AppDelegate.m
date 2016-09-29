//
//  AppDelegate.m
//  TopRegions
//
//  Created by Foster, Jake on 9/28/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "AppDelegate.h"
#import "Region.h"
#import "RegionDatabaseAvailability.h"
#import "FlickrFetcher.h"
#import "Photo.h"
#import "Photographer.h"

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

- (void)setRegionDatabaseContext:(NSManagedObjectContext *)regionDatabaseContext {
    _regionDatabaseContext = regionDatabaseContext;
    NSDictionary *userInfo = self.regionDatabaseContext ? @{ RegionDatabaseAvailabilityContext : self.regionDatabaseContext} : nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:RegionDatabaseAvailabilityNotification
                                                        object:self
                                                      userInfo:userInfo];
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
        [self fetchPhotos];
    } else {
        NSLog(@"document at %@ is not ready", self.regionDatabaseDocument.fileURL);
    }
}

- (void)fetchPhotos {
    NSURL *url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDownloadTask *task =
    [session downloadTaskWithRequest:request
                   completionHandler:^(NSURL * _Nullable localFile, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                       if (!error) {
                           NSData *data = [NSData dataWithContentsOfURL:localFile];
                           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error: NULL];
                           NSArray *photoDicts = [dict valueForKeyPath:FLICKR_RESULTS_PHOTOS];
                           
                           dispatch_async(dispatch_get_main_queue(), ^{
                               for (NSDictionary *photoDict in photoDicts) {
                                   Photo *photo = [Photo getOrCreatePhotoWithFlickrPhotoDictionary:photoDict context:self.regionDatabaseContext];
                                   if (!photo.region) {
                                       [self fetchRegionForPhoto:photo];
                                   } else {
                                       [self addPhotographerName:photo.owner toRegion:photo.region];
                                   }
                               }
                           });
                       }
                   }];
    [task resume];
}

- (void)fetchRegionForPhoto:(Photo *)photo {
    NSURL *url = [FlickrFetcher URLforInformationAboutPlace:photo.placeId];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDownloadTask *task =
    [session downloadTaskWithRequest:request
                   completionHandler:^(NSURL * _Nullable localFile, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                       if (!error) {
                           NSData *data = [NSData dataWithContentsOfURL:localFile];
                           NSDictionary *placeDict = [NSJSONSerialization JSONObjectWithData:data options:0 error: NULL];
                           NSString *regionName = [FlickrFetcher extractRegionNameFromPlaceInformation:placeDict];
                           dispatch_async(dispatch_get_main_queue(), ^{
                               Region *region = [Region getOrCreateRegionWithName:regionName context:self.regionDatabaseContext];
                               photo.region = region;
                               [self addPhotographerName:photo.owner toRegion:region];
                           });
                       }
                   }];
    [task resume];
}

- (void)addPhotographerName:(NSString *)name toRegion:(Region *)region {
    Photographer *photographer = [Photographer getOrCreatePhotographerWithName:name context:self.regionDatabaseContext];
    [region addPhotographersObject:photographer];
    region.photographerCount = @([region.photographers count]);
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
