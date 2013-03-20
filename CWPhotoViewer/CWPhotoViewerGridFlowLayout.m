//
//  CWGridFlowLayout.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/9/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoViewerGridFlowLayout.h"

@implementation CWPhotoViewerGridFlowLayout

- (id)init {

  self = [super init];

  if (self) {

    self.itemSize                = CGSizeMake(75, 75);
    self.sectionInset            = UIEdgeInsetsMake(2.0, 2.0, 2.0, 2.0);
    self.minimumInteritemSpacing = 2.0;
    self.footerReferenceSize     = CGSizeMake(100, 100);
  }

  return self;
}

@end
