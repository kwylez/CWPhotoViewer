//
//  CWGridCell.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/9/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoViewerGridCell.h"

NSString * const CWPhotoViewerGridCellIdentifier = @"THUMBNAIL_CELL";

@implementation CWPhotoViewerGridCell

@synthesize imgView;

- (id)initWithFrame:(CGRect)frame {

  self = [super initWithFrame:frame];

  if (self) {

    [self.contentView addSubview:self.label];

    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];

    [self.contentView addSubview:self.imgView];

    self.contentView.layer.borderWidth = 1.0f;
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
  }

  return self;
}
@end
