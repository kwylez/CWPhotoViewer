//
//  CWMasterViewController.h
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/4/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class CWDetailViewController;

@interface CWPhotoViewerMasterViewController : UITableViewController

@property (strong, nonatomic) CWDetailViewController *detailViewController;

+ (ALAssetsLibrary *)defaultAssetsLibrary;

@end
