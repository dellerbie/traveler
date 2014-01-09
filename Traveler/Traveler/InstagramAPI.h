//
//  InstagramAPI.h
//  Traveler
//
//  Created by Derrick Ellerbie on 1/8/14.
//  Copyright (c) 2014 dellerbie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeoLocation;

typedef void (^InstagramMediaSearchCompletionBlock)(NSArray *results, NSError *error);

@interface InstagramAPI : NSObject

+ (void) mediaSearch:(GeoLocation *)location completionBlock:(InstagramMediaSearchCompletionBlock)completionBlock;

@end
