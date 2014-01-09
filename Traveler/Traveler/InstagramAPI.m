//
//  InstagramAPI.m
//  Traveler
//
//  Created by Derrick Ellerbie on 1/8/14.
//  Copyright (c) 2014 dellerbie. All rights reserved.
//

#import "InstagramAPI.h"
#import "GeoLocation.h"
#import "InstagramPhoto.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

static const NSString *kClientID = @"21bd08d618fc4f16a2aace1b22fe2895";
static const NSString *kClientSecret = @"6ed5fe76a6ec49739e5ab7cc7b984f25";

@implementation InstagramAPI

+ (void) mediaSearch:(GeoLocation *)location completionBlock:(InstagramMediaSearchCompletionBlock)completionBlock
{
  //NSString *searchURL = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/search?lat=%f&lng=%f&distance=5000", location.lat, location.lng];
  NSString *searchURL = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/popular?client_id=%@", kClientID];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:searchURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    NSLog(@"JSON: %@", responseObject);
    NSArray *searchResults = responseObject[@"data"];
    NSMutableArray *photos = [NSMutableArray new];
    for(NSDictionary *data in searchResults)
    {
      if([data[@"type"] isEqualToString:@"video"])
      {
        continue;
      }
      
      InstagramPhoto *photo = [InstagramPhoto new];
      photo.thumbImageURL = [NSURL URLWithString:data[@"images"][@"thumbnail"][@"url"]];
      [photos addObject:photo];
    }
    completionBlock(photos, nil);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
    completionBlock(nil, error);
  }];
}

@end
