//
//  LoginViewController.m
//  Traveler
//
//  Created by Derrick Ellerbie on 1/9/14.
//  Copyright (c) 2014 dellerbie. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ImagesViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [loginButton setTitle:@"Login" forState:UIControlStateNormal];
  [loginButton sizeToFit];
  loginButton.center = CGPointMake(160, 200);
  [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:loginButton];
  
  AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
  appDelegate.instagram.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
  appDelegate.instagram.sessionDelegate = self;
  
  if([appDelegate.instagram isSessionValid])
  {
    ImagesViewController *vc = [ImagesViewController new];
    [self.navigationController pushViewController:vc animated:YES];
  }
}

-(void) login:(id) sender
{
  AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
  [appDelegate.instagram authorize:[NSArray arrayWithObjects:@"comments", @"likes", nil]];
}

#pragma - IGSessionDelegate

-(void)igDidLogin
{
  AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
  [[NSUserDefaults standardUserDefaults] setObject:appDelegate.instagram.accessToken forKey:@"accessToken"];
	[[NSUserDefaults standardUserDefaults] synchronize];
  
  ImagesViewController *vc = [ImagesViewController new];
  [self.navigationController pushViewController:vc animated:YES];
}

-(void)igDidNotLogin:(BOOL)cancelled
{
  NSString* message = nil;
  if (cancelled)
  {
    message = @"Access cancelled!";
  }
  else
  {
    message = @"Access denied!";
  }
  
  UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Couldn't log in to Instagram"
                                                      message:message
                                                     delegate:nil
                                            cancelButtonTitle:@"Ok"
                                            otherButtonTitles:nil];
  [alertView show];
}

-(void)igDidLogout
{
  [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)igSessionInvalidated
{
  NSLog(@"Instagram session was invalidated");
}

@end
