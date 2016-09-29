//
//  Photo.m
//  TopRegions
//
//  Created by Foster, Jake on 9/29/16.
//  Copyright © 2016 Amazon. All rights reserved.
//

#import "Photo.h"
#import "FlickrFetcher.h"

#define PHOTO @"Photo"

@implementation Photo

- (NSURL *)fullSizeUrl {
    return [NSURL URLWithString:self.fullSizeUrlString];
}

- (void)setFullSizeUrl:(NSURL *)fullSizeUrl {
    self.fullSizeUrlString = [fullSizeUrl absoluteString];
}

- (NSURL *)thumbnailUrl {
    return [NSURL URLWithString:self.thumbnailUrlString];
}

- (void)setThumbnailUrl:(NSURL *)thumbnailUrl {
    self.thumbnailUrlString = [thumbnailUrl absoluteString];
}

+ (Photo *)getPhotoWithFickrPhotoDictionary:(NSDictionary *)photoDict context:(NSManagedObjectContext *)context {
    Photo *photo = nil;
    
    NSString *unique = [photoDict valueForKeyPath:FLICKR_PHOTO_ID];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:PHOTO];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", unique];

    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];

    if (!results) {
        NSLog(@"Error fetching photo: %@", error);
    } else if ([results count] > 1) {
        NSLog(@"Error: found multiple photos with same id %@", unique);
    } else if ([results count] == 1){
        photo = results.firstObject;
    }
    return photo;
}


+ (Photo *)getOrCreatePhotoWithFlickrPhotoDictionary:(NSDictionary *)photoDict context:(NSManagedObjectContext *)context {
    Photo *photo = [Photo getPhotoWithFickrPhotoDictionary:photoDict context:context];
    if (photo) {
        return photo;
    } // else create it

    photo = [NSEntityDescription insertNewObjectForEntityForName:PHOTO inManagedObjectContext:context];
    photo.unique = [photoDict valueForKeyPath:FLICKR_PHOTO_ID];
    photo.title = [photoDict valueForKeyPath:FLICKR_PHOTO_TITLE];
    photo.detail = [photoDict valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    photo.owner = [photoDict valueForKeyPath:FLICKR_PHOTO_OWNER];
    photo.placeId = [photoDict valueForKeyPath:FLICKR_PHOTO_PLACE_ID];
    photo.fullSizeUrl = [FlickrFetcher URLforPhoto:photoDict format:FlickrPhotoFormatLarge];
    photo.thumbnailUrl = [FlickrFetcher URLforPhoto:photoDict format:FlickrPhotoFormatSquare];
    return photo;
}

@end
