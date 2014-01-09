//
//  InstagramPhotoCell.h
//  Traveler
//
//  Created by Derrick Ellerbie on 1/8/14.
//  Copyright (c) 2014 dellerbie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InstagramPhoto.h"

@interface InstagramPhotoCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) InstagramPhoto *photo;

@end
