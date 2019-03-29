//
//  LQPhotoBrowse.h
//  Pods
//
//  Created by LittleQ on 2019/3/29.
//

#import <Foundation/Foundation.h>

@interface LQPhotoItems : NSObject

// for image url or local you should only choice one.

// picture from web.
@property(nonatomic, copy)  NSString *url;

// picture from local.
@property (nonatomic, strong) UIImage *sourceImage;
@property(nonatomic, strong) UIView *sourceView;

@end

@protocol LQPhotoBrowseDelegate <NSObject>

@optional

- (void)photoBrowseWillDismiss;

- (void)photoBrowseRightOperationActionWithIndex:(NSInteger)index;

- (void)photoBrowseWriteToSavedPhotosAlbumStatus:(BOOL)success;

- (void)photoBrowseRightOperationDeleteImageSuccessWithRelativeIndex:(NSInteger)index;

- (void)photoBrowseRightOperationDeleteImageSuccessWithAbsoluteIndex:(NSInteger)index;

@end

@interface LQPhotoBrowse : UIView

// current choice image index.
@property (nonatomic, assign) NSInteger currentIndex;

// images list UIView or uri
@property (nonatomic, strong) NSArray *itemsArr;

// ActionSHeet content
@property (nonatomic, strong) NSMutableArray *actionSheetArr;

// button in right top. default: YES
@property (nonatomic, assign) BOOL isNeedRightTopBtn;

// long press event default: YES
@property (nonatomic, assign) BOOL isNeedPictureLongPress;

// page number in top x/y default: YES
@property (nonatomic, assign) BOOL isNeedPageNumView;

// page control in buttom. default: NO
@property (nonatomic, assign) BOOL isNeedPageControl;

//
@property(nonatomic, weak) UIView *sourceViewForCellReusable;

//
@property (nonatomic, strong) NSArray *dataSourceUrlArr;

//
@property(nonatomic, weak) id<LQPhotoBrowseDelegate> delegate;

- (void)present;
- (void)dismiss;

@end
