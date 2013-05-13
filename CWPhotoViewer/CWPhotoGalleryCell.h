//
//  CWPhotoGalleryCell.h
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 5/9/13.
//  Copyright (c) 2013 Cory D. Wiles. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const  CWPhotoGalleryCellIdentifier;

@interface CWPhotoGalleryCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) UINavigationController *navigationControllerContainer;

@end
