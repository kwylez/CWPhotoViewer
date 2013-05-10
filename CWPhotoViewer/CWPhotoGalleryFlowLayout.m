//
//  CWPhotoGalleryLayout.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 5/9/13.
//  Copyright (c) 2013 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoGalleryFlowLayout.h"

@implementation CWPhotoGalleryFlowLayout

- (id)init {
  
  self = [super init];
  
  if (self) {
    
    self.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 0.0f;
    self.minimumLineSpacing      = 0.0f;
  }
  
  return self;
}

@end
