//
//  CWMasterViewController.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 7/4/12.
//  Copyright (c) 2012 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoViewerMasterViewController.h"

#import "CWPhotoViewerGalleryImagesViewController.h"
#import "CWPhotoViewerGridFlowLayout.h"

@interface CWPhotoViewerMasterViewController()
@property (nonatomic, strong)  NSMutableArray *objects;

- (void)fetchGalleryListings;

@end

@implementation CWPhotoViewerMasterViewController

#pragma mark - Public Methods

+ (ALAssetsLibrary *)defaultAssetsLibrary {

  static dispatch_once_t pred     = 0;
  static ALAssetsLibrary *library = nil;

  dispatch_once(&pred, ^{
    library = [[ALAssetsLibrary alloc] init];
  });

  return library;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  if (self) {

    self.title = NSLocalizedString(@"Albums", nil);

    self.tableView.rowHeight = 55;
  }

  return self;
}
							
- (void)viewDidLoad {

  [super viewDidLoad];

  [self.tableView registerClass:[UITableViewCell class]
         forCellReuseIdentifier:@"Cell"];

  [self fetchGalleryListings];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  static NSString *CellIdentifier = @"Cell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

  cell.accessoryType         = UITableViewCellAccessoryDisclosureIndicator;
  cell.imageView.frame       = CGRectMake(0, 0, 55, 55);
  cell.imageView.contentMode = UIViewContentModeScaleAspectFit;

  ALAssetsGroup *g = (ALAssetsGroup*)[self.objects objectAtIndex:indexPath.row];

  [g setAssetsFilter:[ALAssetsFilter allPhotos]];

  NSInteger gCount = [g numberOfAssets];

  cell.textLabel.text = [NSString stringWithFormat:@"%@ (%d)",[g valueForProperty:ALAssetsGroupPropertyName], gCount];
  cell.textLabel.adjustsFontSizeToFitWidth = YES;

  [cell.imageView setImage:[UIImage imageWithCGImage:[(ALAssetsGroup *)[_objects objectAtIndex:indexPath.row] posterImage]]];

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  CWPhotoViewerGridFlowLayout *layout = [[CWPhotoViewerGridFlowLayout alloc] init];
  ALAssetsGroup *g         = (ALAssetsGroup*)[self.objects objectAtIndex:indexPath.row];

  CWPhotoViewerGalleryImagesViewController *gallery = [[CWPhotoViewerGalleryImagesViewController alloc] initWithCollectionViewLayout:layout];

  gallery.photoGroup   = g;
  gallery.galleryTitle = [g valueForProperty:ALAssetsGroupPropertyName];

  self.navigationController.navigationBar.translucent = YES;

  [self.navigationController pushViewController:gallery animated:YES];
}

#pragma mark - Private Methods

- (void)fetchGalleryListings {

  ALAssetsLibrary *library = [CWPhotoViewerMasterViewController defaultAssetsLibrary];

  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);

  dispatch_async(queue, ^{

    [library enumerateGroupsWithTypes:ALAssetsGroupAlbum|ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {

      if (group) {

        if ([group valueForProperty:ALAssetsGroupPropertyName]) {

          if (!self.objects) {

            self.objects = [[NSMutableArray alloc] init];
          }

          NSLog(@"album: %@", [group valueForProperty:ALAssetsGroupPropertyName]);

          [self.objects addObject:group];

          dispatch_async(dispatch_get_main_queue(), ^{
            [[self tableView] reloadData];
          });
        }
      }

    } failureBlock:^(NSError *error) {

      NSLog(@"error loading assets: %@", [error localizedDescription]);
    }];
  });
}

@end
