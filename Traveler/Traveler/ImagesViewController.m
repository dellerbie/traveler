//
//  ImagesViewController.m
//  Traveler
//
//  Created by Derrick Ellerbie on 1/8/14.
//  Copyright (c) 2014 dellerbie. All rights reserved.
//

#import "ImagesViewController.h"
#import "InstagramAPI.h"
#import "GeoLocation.h"
#import "InstagramPhoto.h"
#import "InstagramPhotoCell.h"
#import "AppDelegate.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

static NSString *CellIdentifier = @"CellIdentifier";

@interface ImagesViewController ()
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) NSArray *tags;
@end

@implementation ImagesViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
  self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
  self.collectionView.dataSource = self;
  self.collectionView.delegate = self;
  [self.collectionView registerClass:[InstagramPhotoCell class] forCellWithReuseIdentifier:CellIdentifier];
  self.collectionView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.collectionView];
  
  self.searchResults = @[];
  
  UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                            action:@selector(logout:)];
  self.navigationItem.leftBarButtonItem = logoutButton;
  
  UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
  self.navigationItem.rightBarButtonItem = refreshButton;
  
  
  self.tags = @[@"fender", @"fenderamp", @"fenderguitar", @"fenderstratocaster", @"fendertelecaster", @"fenderbass", @"gibson", @"gibsonlespaul", @"gibsonguitars", @"vox", @"korg", @"rhodespiano"];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self loadData];
}

- (void) refresh:(id)sender
{
  [self loadData];
}

- (void) loadData
{
  int random = arc4random()%[self.tags count];
  NSString *tag = [self.tags objectAtIndex:random];
  self.title = tag;
  
  [InstagramAPI mediaSearch:nil completionBlock:^(NSArray *results, NSError *error) {
    if(error == nil)
    {
      NSLog(@"Found %i photos", [results count]);
      self.searchResults = results;
      [self.collectionView reloadData];
    }
    else
    {
      NSLog(@"Error fetching photos from IG. Error: %@", error);
    }
  }];
}

- (void) logout:(id)sender
{
  AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
  [appDelegate.instagram logout];
  [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [self.searchResults count];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
  return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
  return 2.0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  InstagramPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
  cell.photo = [self.searchResults objectAtIndex:indexPath.row];
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(105, 105);
}


@end
