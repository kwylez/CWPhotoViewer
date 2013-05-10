//
//  CWGalleryPhotoListingFooterView.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 9/27/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoViewerGalleryPhotoListingFooterView.h"

NSString * const CWPhotoViewerFooterIdentifier = @"PhotoListingFooter";

@implementation CWPhotoViewerGalleryPhotoListingFooterView

- (id)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];

  if (self) {

    _numberOfPhotos = [[UILabel alloc] initWithFrame:CGRectZero];

    _numberOfPhotos.textAlignment = NSTextAlignmentCenter;
    _numberOfPhotos.font          = [UIFont systemFontOfSize:28.0f];

    [self addSubview:_numberOfPhotos];
  }

  return self;
}

- (void)layoutSubviews {
  self.numberOfPhotos.frame = self.bounds;
}

@end
