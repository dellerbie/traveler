//
//  InstagramPhotoCell.m
//  Traveler
//
//  Created by Derrick Ellerbie on 1/8/14.
//  Copyright (c) 2014 dellerbie. All rights reserved.
//

#import "InstagramPhotoCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation InstagramPhotoCell

- (id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if(self)
  {
    self.imageView = [[UIImageView alloc] initWithFrame:frame];
    [self addSubview:self.imageView];
  }
  return self;
}

- (void) setPhoto:(InstagramPhoto *)photo
{
  if(_photo != photo)
  {
    _photo = photo;
  }
  
  NSLog(@"setPhoto: %@", photo.thumbImageURL);
  
  [self.imageView setImageWithURL:photo.thumbImageURL];
}

@end
