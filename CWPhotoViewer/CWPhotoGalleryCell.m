//
//  CWPhotoGalleryCell.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 5/9/13.
//  Copyright (c) 2013 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoGalleryCell.h"

NSString * const  CWPhotoGalleryCellIdentifier = @"CWPhotoGalleryCell";

static const CGFloat ZOOM_FACTOR     = 1.5f;
static const CGFloat MAX_ZOOM_FACTOR = 2.5f;

@interface CWPhotoGalleryCell() <UIScrollViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL navigationVisible;

- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center;
- (void)addGestures;
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer;
- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer;
- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer;
- (void)toggleNavigationVisibleWithAnimation;

@end

@implementation CWPhotoGalleryCell

- (id)initWithFrame:(CGRect)frame {
  
  self = [super initWithFrame:frame];
  
  if (self) {

    _navigationVisible = NO;

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    
    _scrollView.clipsToBounds = YES;
    _scrollView.delegate      = self;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _imageView.contentMode            = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = YES;
    
    [_scrollView addSubview:_imageView];

    [self.contentView addSubview:_scrollView];
    
    [self addGestures];
  }

  return self;
}

- (void)layoutSubviews {
  
  [super layoutSubviews];
  
  self.scrollView.frame       = self.imageView.frame = self.bounds;
  self.scrollView.contentSize = self.imageView.frame.size;
  
  CGFloat minimumScale = self.scrollView.frame.size.width / self.imageView.frame.size.width;

  self.scrollView.maximumZoomScale = MAX_ZOOM_FACTOR;
  self.scrollView.minimumZoomScale = minimumScale;
  self.scrollView.zoomScale        = minimumScale;
}

#pragma mark - Setters

- (void)setImage:(UIImage *)image {

  _image = image;

  self.imageView.image = image;
}

#pragma mark - UIScrollView Delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return self.imageView;
}

#pragma makr - UIGestureRecognizer Delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
  return YES;
}

#pragma mark - Private Methods

- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)center {
  
  CGRect zoomRect;
  
  /**
   * The zoom rect is in the content view's coordinates.
   * At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
   * As the zoom scale decreases, so more content is visible, the size of the rect grows.
   */

  zoomRect.size.height = self.scrollView.frame.size.height / scale;
  zoomRect.size.width  = self.scrollView.frame.size.width / scale;

  /**
   * Get the correct origin from center and zoom
   */
  
  zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0);
  zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
  
  return zoomRect; 
}

- (void)addGestures {
  
  UITapGestureRecognizer *singleTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
  UITapGestureRecognizer *doubleTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
  UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)];
  
  singleTap.delegate = self;
  
  [singleTap setNumberOfTapsRequired:1];
  [doubleTap setNumberOfTapsRequired:2];
  [twoFingerTap setNumberOfTouchesRequired:2];

  [self.imageView addGestureRecognizer:singleTap];
  [self.imageView addGestureRecognizer:doubleTap];
  [self.imageView addGestureRecognizer:twoFingerTap];
  
  [singleTap requireGestureRecognizerToFail:doubleTap];
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {

  if (self.navigationControllerContainer) {
    [self toggleNavigationVisibleWithAnimation];
  }
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {

  CGFloat newScale = self.scrollView.zoomScale * ZOOM_FACTOR;
  CGRect zoomRect  = [self zoomRectForScale:newScale
                                 withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
  
  [self.scrollView zoomToRect:zoomRect animated:YES];
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)gestureRecognizer {

  CGFloat newScale = self.scrollView.zoomScale / ZOOM_FACTOR;
  CGRect zoomRect  = [self zoomRectForScale:newScale
                                 withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];

  [self.scrollView zoomToRect:zoomRect animated:YES];
}

- (void)toggleNavigationVisibleWithAnimation {
  
  self.navigationVisible = !self.navigationVisible;

  [self.navigationControllerContainer setNavigationBarHidden:self.navigationVisible animated:YES];
}

@end
