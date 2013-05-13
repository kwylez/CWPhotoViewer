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

    self.itemSize                = CGSizeMake(75, 82);
    self.sectionInset            = UIEdgeInsetsMake(4.0, 4.0, 4.0, 4.0);
    self.minimumInteritemSpacing = 4.0f;
    self.footerReferenceSize     = CGSizeMake(100, 100);
    self.minimumLineSpacing      = 4.0f;
  }

  return self;
}

@end
