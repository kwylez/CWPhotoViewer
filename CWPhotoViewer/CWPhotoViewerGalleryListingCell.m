//
//  CWPhotoViewerGalleryListingCell.m
//  CWPhotoViewer
//
//  Created by Cory D. Wiles on 3/20/13.
//  Copyright (c) 2013 Cory D. Wiles. All rights reserved.
//

#import "CWPhotoViewerGalleryListingCell.h"

@interface CWPhotoViewerGalleryListingCell()
- (void)addConstraintsForView;
@end

@implementation CWPhotoViewerGalleryListingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

  self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];

  if (self) {

    self.accessoryType         = UITableViewCellAccessoryDisclosureIndicator;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;

    /**
     * Gallery Count
     */

    _galleryCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];

    _galleryCountLabel.textColor = [UIColor lightGrayColor];

    _galleryCountLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [self.contentView addSubview:_galleryCountLabel];

    /**
     * Gallery Name
     */

    _galleryNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];

    _galleryNameLabel.textColor = [UIColor blackColor];
    _galleryNameLabel.font      = [UIFont boldSystemFontOfSize:17.0f];

    _galleryNameLabel.translatesAutoresizingMaskIntoConstraints = NO;

    [self.contentView addSubview:_galleryNameLabel];

    [self addConstraintsForView];
  }

  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

#pragma mark - Private Methods

- (void)addConstraintsForView {

  NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_galleryNameLabel
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.imageView
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1.0f
                                                                 constant:10.0f];

  [self.contentView addConstraint:constraint];

  constraint = [NSLayoutConstraint constraintWithItem:_galleryNameLabel
                                            attribute:NSLayoutAttributeCenterY
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.imageView
                                            attribute:NSLayoutAttributeCenterY
                                           multiplier:1.0f
                                             constant:0.0f];

  [self.contentView addConstraint:constraint];

  constraint = [NSLayoutConstraint constraintWithItem:_galleryNameLabel
                                            attribute:NSLayoutAttributeWidth
                                            relatedBy:NSLayoutRelationLessThanOrEqual
                                               toItem:nil
                                            attribute:NSLayoutAttributeNotAnAttribute
                                           multiplier:1.0f
                                             constant:180.0f];

  [self.contentView addConstraint:constraint];

  constraint = [NSLayoutConstraint constraintWithItem:_galleryCountLabel
                                            attribute:NSLayoutAttributeLeft
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:_galleryNameLabel
                                            attribute:NSLayoutAttributeRight
                                           multiplier:1.0f
                                             constant:10.0f];

  [self.contentView addConstraint:constraint];

  constraint = [NSLayoutConstraint constraintWithItem:_galleryCountLabel
                                            attribute:NSLayoutAttributeCenterY
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:_galleryNameLabel
                                            attribute:NSLayoutAttributeCenterY
                                           multiplier:1.0f
                                             constant:0.0f];

  [self.contentView addConstraint:constraint];
}

@end
