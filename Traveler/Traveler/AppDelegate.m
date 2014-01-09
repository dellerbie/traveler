//
//  AppDelegate.m
//  Traveler
//
//  Created by Derrick Ellerbie on 1/8/14.
//  Copyright (c) 2014 dellerbie. All rights reserved.
//

#import "AppDelegate.h"
#import "ImagesViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

  ImagesViewController *vc = [ImagesViewController new];
  [self.window setRootViewController:vc];
  
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

@end
