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
#import "AppDelegate.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@implementation InstagramAPI

+ (void) mediaSearch:(NSString *)tag completionBlock:(InstagramMediaSearchCompletionBlock)completionBlock
{
  AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
  
  //NSString *searchURL = [NSString stringWithFormat:@"https://api.instagram.com/v1/media/search?lat=%f&lng=%f&distance=5000&access_token=%@", location.lat, location.lng, appDelegate.instagram.accessToken];
  
  NSString *searchURL = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?access_token=%@", tag, appDelegate.instagram.accessToken];
  
  // TODO: CHECK FOR IG OAUTH ERROR
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:searchURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    completionBlock(nil, error);
  }];
}

@end
