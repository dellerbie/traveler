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
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
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
  
  [self.imageView setImageWithURL:photo.thumbImageURL];
}

@end
