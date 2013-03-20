//
//  CWFullScreenPhotoViewController.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/9/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoViewerPhotoViewController.h"

@interface CWPhotoViewerPhotoViewController ()

@end

@implementation CWPhotoViewerPhotoViewController

@synthesize photo;

- (void)loadView {

  self.view = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.view.backgroundColor  = [UIColor blackColor];
}

- (void)viewDidLoad {

  [super viewDidLoad];

  UIImageView *imgView   = (UIImageView *)self.view;
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);

  imgView.contentMode = UIViewContentModeScaleAspectFit;

  dispatch_async(queue, ^{

    ALAssetRepresentation *rep = [self.photo defaultRepresentation];
    CGImageRef ref             = [rep fullScreenImage];

    dispatch_sync(dispatch_get_main_queue(), ^{
      imgView.image = [[UIImage alloc] initWithCGImage:ref];
    });
  });
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

@end
