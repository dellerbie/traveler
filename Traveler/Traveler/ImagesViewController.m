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
#import <AFNetworking/UIImageView+AFNetworking.h>

static NSString *CellIdentifier = @"CellIdentifier";

@interface ImagesViewController ()

@property (nonatomic, strong) NSArray *searchResults;

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
  
//  GeoLocation *location = [GeoLocation new];
//  location.lat = 16.4944;
//  location.lng = 151.7364;
  
  self.searchResults = [NSArray new];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
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
  InstagramPhotoCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
  cell.backgroundColor = [UIColor redColor];
  cell.photo = [self.searchResults objectAtIndex:indexPath.row];
  
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(105, 105);
}


@end
