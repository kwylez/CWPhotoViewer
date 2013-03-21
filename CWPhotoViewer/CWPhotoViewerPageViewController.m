//
//  CWPhotoPageViewController.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/9/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoViewerPageViewController.h"
#import "CWPhotoViewerPhotoViewController.h"

@interface CWPhotoViewerPageViewController ()
- (void)initPageViewController;
- (void)setupInitalPhotoPage;
@end

@implementation CWPhotoViewerPageViewController

- (id)initWithIndex:(NSInteger)idx {

  self = [super init];

  if (self) {

    _imageArray   = [NSArray new];
    _currentIndex = idx;
  }

  return self;
}

- (id)init {
  return [self initWithIndex:0];
}

- (void)loadView {

  self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLoad {

  [super viewDidLoad];

  [self initPageViewController];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Datasource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

  ALAsset *currentPhotoObject = (ALAsset *)[(CWPhotoViewerPhotoViewController *)viewController photo];

  NSUInteger currentIndex = [self.imageArray indexOfObject:currentPhotoObject];

  if (currentIndex == 0) {
    return nil;
  }

  _currentIndex -= 1;

  CWPhotoViewerPhotoViewController *photoViewController = [[CWPhotoViewerPhotoViewController alloc] init];

  photoViewController.photo = (ALAsset *)self.imageArray[_currentIndex];

  return photoViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

  ALAsset *currentPhotoObject = (ALAsset *)[(CWPhotoViewerPhotoViewController *)viewController photo];

  NSUInteger currentIndex     = [self.imageArray indexOfObject:currentPhotoObject];

  if (currentIndex == (self.imageArray.count - 1)) {
    return nil;
  }

  _currentIndex += 1;

  CWPhotoViewerPhotoViewController *photoViewController = [[CWPhotoViewerPhotoViewController alloc] init];

  photoViewController.photo = self.imageArray[_currentIndex];

  return photoViewController;
}

#pragma mark - Private Methods

- (void)initPageViewController {

  [self setupInitalPhotoPage];

  [self addChildViewController:self.pageController];

  [self.view addSubview:self.pageController.view];

  [self.pageController didMoveToParentViewController:self];

  CGRect pageViewRect = self.view.bounds;

  self.pageController.view.frame = pageViewRect;

  self.view.gestureRecognizers = self.pageController.gestureRecognizers;
}

- (void)setupInitalPhotoPage {

  if (_currentIndex > self.imageArray.count - 1 || _currentIndex < 0) {
    _currentIndex = 0;
  }

  NSDictionary *options = @{[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] : UIPageViewControllerOptionSpineLocationKey};

  self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                        navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                      options:options];
  self.pageController.delegate   = self;
  self.pageController.dataSource = self;

  ALAsset *initPhoto = (ALAsset *)self.imageArray[_currentIndex];

  CWPhotoViewerPhotoViewController *photoViewController = [[CWPhotoViewerPhotoViewController alloc] init];

  photoViewController.photo = initPhoto;

  [self.pageController setViewControllers:@[photoViewController]
                                direction:UIPageViewControllerNavigationDirectionForward
                                 animated:NO
                               completion:^(BOOL finished){NSLog(@"I am finished");}];
}

@end
