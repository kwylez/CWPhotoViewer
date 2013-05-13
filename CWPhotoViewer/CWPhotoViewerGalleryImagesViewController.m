//
//  CWPhotoGalleryListingViewController.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/9/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoViewerGalleryImagesViewController.h"
#import "CWPhotoViewerGridCell.h"
#import "CWPhotoViewerPhotoViewController.h"
#import "CWPhotoGalleryFlowLayout.h"
#import "CWPhotoViewerGalleryPhotoListingFooterView.h"

@interface CWPhotoViewerGalleryImagesViewController ()

@property (nonatomic, strong) NSMutableArray *galleryImages;

- (void)fetchGalleryImages;

@end

@implementation CWPhotoViewerGalleryImagesViewController

@synthesize photoGroup;

- (void)viewDidLoad {

  [super viewDidLoad];

  self.title = NSLocalizedString(self.galleryTitle, nil);

  /**
   * ::NOTE::
   * Because are using a translucent navbar we have to adjust the content
   * inset to the size of the navbar height so that the collectionView isn't 
   * hidden underneath.
   *
   * You __dont'__ have this problem with opaque type.
   */

  [self.collectionView setContentInset:UIEdgeInsetsMake(self.navigationController.navigationBar.frame.size.height, 0, 0, 0)];

  self.collectionView.backgroundColor = [UIColor whiteColor];

  [self.collectionView registerClass:[CWPhotoViewerGridCell class]
          forCellWithReuseIdentifier:CWPhotoViewerGridCellIdentifier];

  [self.collectionView registerClass:[CWPhotoViewerGalleryPhotoListingFooterView class]
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                 withReuseIdentifier:CWPhotoViewerFooterIdentifier];

  [self fetchGalleryImages];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section; {
  return [self.photoGroup numberOfAssets];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath; {

  CWPhotoViewerGridCell *cell = [cv dequeueReusableCellWithReuseIdentifier:CWPhotoViewerGridCellIdentifier
                                                   forIndexPath:indexPath];

  ALAsset *asset     = (ALAsset *)[self galleryImages][indexPath.row];
  UIImage *thumbnail = [UIImage imageWithCGImage:[asset thumbnail]];

  cell.label.text    = [NSString stringWithFormat:@"%d",indexPath.item];
  cell.imgView.image = thumbnail;

  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
  CWPhotoGalleryFlowLayout *galleryFlowLayout     = [[CWPhotoGalleryFlowLayout alloc] init];
  CWPhotoViewerPhotoViewController *galleryViewer = [[CWPhotoViewerPhotoViewController alloc] initWithPhotos:[self galleryImages]
                                                                                                 atIndexPath:indexPath
                                                                                     forCollectionViewLayout:galleryFlowLayout];
  
  [self.navigationController pushViewController:galleryViewer animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {

  /**
   * Even though this method has been implemented it will NOT get called unless
   * you set the footerReferenceSize property.
   *
   * Reference:
   * @link http://developer.apple.com/library/ios/#Documentation/UIKit/Reference/UICollectionViewFlowLayout_class/Reference/Reference.html
   *
   * If the delegate does not implement the
   * collectionView:layout:referenceSizeForFooterInSection: method, the flow
   * layout object uses the default footer sizes set for this property.

   * During layout, only the size that corresponds to the appropriate scrolling
   * direction is used. For example, for the vertical scrolling direction, the
   * layout object uses the height value specified by this property. (In that
   * instance, the width of the footer would be set to the width of the
   * collection view.) If the size in the appropriate scrolling dimension is 0,
   * no footer is added.

   * The default size values are (0, 0).
   */

  if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {

    CWPhotoViewerGalleryPhotoListingFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                     withReuseIdentifier:CWPhotoViewerFooterIdentifier
                                                                                            forIndexPath:indexPath];

    footerView.numberOfPhotos.text = [NSString stringWithFormat:@"%d photos", [self.galleryImages count]];

    return footerView;
  }

  return nil;
}

#pragma mark - Private Methods

- (void)fetchGalleryImages {

  if (!self.galleryImages.count) {

    self.galleryImages = [NSMutableArray new];

    [self.photoGroup enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {

      if (asset) {
        [self.galleryImages addObject:asset];
      }
    }];

    [self.collectionView reloadData];
  }
}

@end
