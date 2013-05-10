//
//  CWPhotoGalleryCell.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 5/9/13.
//  Copyright (c) 2013 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoGalleryCell.h"

NSString * const  CWPhotoGalleryCellIdentifier = @"CWPhotoGalleryCell";

@interface CWPhotoGalleryCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CWPhotoGalleryCell

- (id)initWithFrame:(CGRect)frame
{
  
  self = [super initWithFrame:frame];
  
  if (self) {

    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:_imageView];
  }
  return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
