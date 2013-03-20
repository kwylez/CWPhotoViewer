//
//  CWPhotoPageViewController.h
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/9/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class CWPhotoViewerPhotoViewController;

@interface CWPhotoViewerPageViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UIPageViewController *pageController;

@end
