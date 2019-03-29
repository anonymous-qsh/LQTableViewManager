//
// LQPhotoBrowseCell.m
//
// Created by LittleQ on 2019-03-29.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "LQPhotoBrowseCell.h"
#import "LQPhotoBrowseImageView.h"

@implementation LQPhotoBrowseCell {
  LQPhotoBrowseImageView *_photoBrowseImageView;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self setupImageView];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self setupImageView];
  }
  return self;
}

- (void)setupImageView {
  __weak typeof(self) weakSelf = self;
  LQPhotoBrowseImageView *photoBrowseView = [[LQPhotoBrowseImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
  photoBrowseView.singleTapBlock = ^() {
    if (weakSelf.singleTap) {
      weakSelf.singleTap();
    }
  };

  photoBrowseView.longPressBlock = ^() {
    if (weakSelf.longPress) {
      weakSelf.longPress();
    }
  };

  _photoBrowseImageView = photoBrowseView;
  [self.contentView addSubview:photoBrowseView];
}

- (void)sd_ImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeHolder {
  [_photoBrowseImageView sd_ImageWithUrl:[NSURL URLWithString:url] placeHolder:placeHolder];
}

- (void)prepareForReuse {
  [_photoBrowseImageView.scrollView setZoomScale:1.f animated:NO];
}

@end