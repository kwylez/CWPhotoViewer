//
//  CWGalleryPhotoListingFooterView.h
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 9/27/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const CWPhotoViewerFooterIdentifier;

@interface CWPhotoViewerGalleryPhotoListingFooterView : UICollectionReusableView

@property (nonatomic, strong) UILabel *numberOfPhotos;

@end
