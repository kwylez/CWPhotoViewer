//
//  CWFullScreenPhotoViewController.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/9/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoViewerPhotoViewController.h"
#import "CWPhotoGalleryCell.h"

@interface CWPhotoViewerPhotoViewController()

@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation CWPhotoViewerPhotoViewController

- (id)initWithPhotos:(NSArray *)photos
         atIndexPath:(NSIndexPath *)indexPath
forCollectionViewLayout:(UICollectionViewLayout *)layout {

  self = [super initWithCollectionViewLayout:layout];
  
  if (self) {
  
    self.clearsSelectionOnViewWillAppear = YES;

    _imageArray        = [photos copy];
    _selectedIndexPath = indexPath;
  }
  
  return self;
}

- (void)viewDidLoad {

  [super viewDidLoad];

  [self.collectionView setPagingEnabled:YES];
  [self.collectionView registerClass:[CWPhotoGalleryCell class]
          forCellWithReuseIdentifier:CWPhotoGalleryCellIdentifier];
  
  [self.collectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
}

#pragma mark - UICollectionView Delegate and Datasource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [self.imageArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  CWPhotoGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CWPhotoGalleryCellIdentifier
                                                                       forIndexPath:indexPath];
  
  cell.navigationControllerContainer = self.navigationController;

  ALAsset *photo             = [self.imageArray objectAtIndex:indexPath.row];
  ALAssetRepresentation *rep = [photo defaultRepresentation];

  CGImageRef ref = [rep fullScreenImage];
  UIImage *img   = [[UIImage alloc] initWithCGImage:ref];
  
  cell.image = img;

  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

  return self.view.bounds.size;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
