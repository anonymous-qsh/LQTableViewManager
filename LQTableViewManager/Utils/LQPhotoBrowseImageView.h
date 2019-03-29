//
//  LQPhotoBrowseImageView.h
//  Pods
//
//  Created by LittleQ on 2019/3/29.
//

#import <UIKit/UIKit.h>

typedef void (^SingleTapBlock)();
typedef void (^LongPressBlock)();

@interface LQPhotoBrowseImageView : UIView

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, copy) SingleTapBlock singleTapBlock;
@property(nonatomic, copy) LongPressBlock longPressBlock;

- (void)sd_ImageWithUrl:(NSURL *)url placeHolder:(UIImage *)placeHolder;

- (void)reloadFrames;

@end
