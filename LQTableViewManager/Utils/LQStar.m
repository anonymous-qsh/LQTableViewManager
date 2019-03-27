//
// LQStar.m
//
// Created by LittleQ on 2019-03-27.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "LQStar.h"
#import "NSBundle+RETableViewManager.h"

#define STAR_YELLOW_NAME @"LQ_Star_Yellow"
#define STAR_GRAY_NAME @"LQ_Star_Gray"
#define DEFAULT_STAR_NUMBER 5
#define ANIMATION_TIME_INTERVAL 0.1

@interface LQStar ()

@property(nonatomic, strong) UIView *foregroundStarView;
@property(nonatomic, strong) UIView *backgroundStarView;
@property(nonatomic, assign) NSInteger numberOfStars;

@end

@implementation LQStar

- (instancetype)initWithFrame:(CGRect)frame {
  return [self initWithFrame:frame numberOfStars:DEFAULT_STAR_NUMBER];
}

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars {
  if (self = [super initWithFrame:frame]) {
    _numberOfStars = numberOfStars;
    [self initDataAndCreateUI];
  }
  return self;
}

- (void)initDataAndCreateUI {

  _scorePercent = 1;
  _isAnimation = NO;
  _isCompleteStar = NO;
  _isJustDisplay = NO;
  self.foregroundStarView = [self createStarViewWithImage:STAR_YELLOW_NAME];
  self.backgroundStarView = [self createStarViewWithImage:STAR_GRAY_NAME];

  [self addSubview:self.backgroundStarView];
  [self addSubview:self.foregroundStarView];

  UITapGestureRecognizer
      *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapRateView:)];
  tapGesture.numberOfTapsRequired = 1;
  [self addGestureRecognizer:tapGesture];

}

- (void)userTapRateView:(UITapGestureRecognizer *)gesture {
  CGPoint tapPoint = [gesture locationInView:self];
  CGFloat offset = tapPoint.x;
  CGFloat realStarScore = offset / (self.bounds.size.width / self.numberOfStars);
  CGFloat starScore = self.isCompleteStar ? ceilf(realStarScore) : realStarScore;

  if (_isJustDisplay) {
    return;

  } else {

    self.scorePercent = starScore / self.numberOfStars;
    if (self.sendStarPercent) {
      self.sendStarPercent(self.scorePercent);
    }

  }

}

- (UIView *)createStarViewWithImage:(NSString *)imageName {

  UIView *view = [[UIView alloc] initWithFrame:self.bounds];
  view.clipsToBounds = YES;
  view.backgroundColor = [UIColor clearColor];
  for (NSInteger i = 0; i < self.numberOfStars; i++) {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName inBundle:[NSBundle RETableViewManagerBundle] compatibleWithTraitCollection:nil]];
    imageView.frame = CGRectMake(i * self.bounds.size.width / self.numberOfStars,
                                 0,
                                 self.bounds.size.width / self.numberOfStars,
                                 self.bounds.size.height);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
  }
  return view;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  __weak LQStar *weakSelf = self;
  CGFloat animationTimeInterval = (CGFloat) (self.isAnimation ? ANIMATION_TIME_INTERVAL : 0);

  [UIView animateWithDuration:animationTimeInterval animations:^{

    weakSelf.foregroundStarView.frame =
        CGRectMake(0, 0, weakSelf.bounds.size.width * weakSelf.scorePercent, weakSelf.bounds.size.height);
  }];
}

#pragma mark - Get and Set Methods

- (void)setScorePercent:(CGFloat)scorePercent {
  if (_scorePercent == scorePercent) {
    return;
  }
  if (scorePercent < 0) {
    _scorePercent = 0;
  } else if (scorePercent > 1) {
    _scorePercent = 1;
  } else {
    _scorePercent = scorePercent;
  }
  [self setNeedsLayout];
}

@end
