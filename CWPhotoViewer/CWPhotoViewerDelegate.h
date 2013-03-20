//
//  CWAppDelegate.h
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/4/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWPhotoViewerDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;

@end
