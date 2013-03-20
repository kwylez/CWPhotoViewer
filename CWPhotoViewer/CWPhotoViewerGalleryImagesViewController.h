//
//  CWPhotoGalleryListingViewController.h
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/9/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CWPhotoViewerGalleryImagesViewController : UICollectionViewController

@property (nonatomic, strong) ALAssetsGroup *photoGroup;
@property (nonatomic, copy) NSString *galleryTitle;

@end
