//
//  CWFullScreenPhotoViewController.h
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/9/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CWPhotoViewerPhotoViewController : UICollectionViewController

@property (nonatomic, assign, readonly) NSInteger currentIndex;

- (id)initWithPhotos:(NSArray *)photos
             atIndex:(NSInteger)idx
forCollectionViewLayout:(UICollectionViewLayout *)layout;

@end
