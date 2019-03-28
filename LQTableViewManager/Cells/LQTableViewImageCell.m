//
// LQTableViewImageCell.m
//
// Created by LittleQ on 2019-03-28.
// Copyright (c) 2019 Little.Q All rights reserved.
//

#import "LQTableViewImageCell.h"
#import "LQImageItem.h"
#import "NSBundle+RETableViewManager.h"

#define TEXT_MARGIN_LEFT 20

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define kKeyWindow [UIApplication sharedApplication].keyWindow

@interface LQTableViewImageCell ()

@end

@implementation LQTableViewImageCell {
  float viewWidth;
  float viewHeight;
  UIView *pickerButton;
  UIImagePickerController *imagePicker;
}

- (void)cellDidLoad {

  [super cellDidLoad];

  self.contentView.frame = CGRectZero;

  float width = SCREEN_WIDTH - 36;

  viewWidth = (width - 5 * TEXT_MARGIN_LEFT) / 4;
  viewHeight = viewWidth;

  self.item.imageList = [[NSMutableArray alloc] init];

  imagePicker = [[UIImagePickerController alloc] init];

  UIButton *doneButton = [[UIButton alloc] init];
  doneButton.frame = CGRectMake(SCREEN_WIDTH - 80, 0, 80, 44);

  [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

  [doneButton bk_whenTapped:^{
    [self->imagePicker dismissViewControllerAnimated:YES completion:nil];
  }];

  [imagePicker.navigationBar addSubview:doneButton];

  [self initPickerButton];
  
}

- (void)cellWillAppear {
  [super cellWillAppear];
}

- (void)initPickerButton {
  NSUInteger index = 0;
  float x = (index % 4) * viewWidth + (index % 4 + 1) * TEXT_MARGIN_LEFT;
  float y = (index / 4) * viewHeight + (index / 4) * TEXT_MARGIN_LEFT;
  pickerButton = [[UIView alloc] initWithFrame:CGRectMake(x, y, viewWidth, viewHeight)];
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewWidth)];
  if (@available(iOS 8.0, *)) {
    imageView.image =
    [UIImage imageNamed:@"Upload_Image" inBundle:[NSBundle RETableViewManagerBundle] compatibleWithTraitCollection:nil];
  } else {
    // Fallback on earlier versions
  }

  [pickerButton addSubview:imageView];

  pickerButton.layer.masksToBounds = YES;
  pickerButton.layer.cornerRadius = 5.0;
  pickerButton.layer.borderWidth = 1.0;
  pickerButton.layer.borderColor = [UIColor lightGrayColor].CGColor;

  [self.contentView addSubview:pickerButton];
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage:)];
  [pickerButton addGestureRecognizer:tapGesture];
}

- (void)updateImageView:(UIImageView *)imageView index:(NSUInteger)index {

  float x = (index % 4) * viewWidth + (index % 4 + 1) * TEXT_MARGIN_LEFT;
  float y = (index / 4) * viewHeight + (index / 4) * TEXT_MARGIN_LEFT;

  CGRect rect = CGRectMake(x, y, viewWidth, viewHeight);
  imageView.frame = rect;
}

- (void)updatePickerButton:(NSUInteger)index {
  float x = (index % 4) * viewWidth + (index % 4 + 1) * TEXT_MARGIN_LEFT;
  float y = (index / 4) * viewHeight + (index / 4) * TEXT_MARGIN_LEFT;
  CGRect rect = CGRectMake(x, y, viewWidth, viewHeight);
  pickerButton.frame = rect;
}

- (void)addImageCell:(NSUInteger)index image:(UIImage *)image {
  float x = (index % 4) * viewWidth + (index % 4 + 1) * TEXT_MARGIN_LEFT;
  float y = (index / 4) * viewHeight + (index / 4) * TEXT_MARGIN_LEFT;
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, viewWidth, viewHeight)];
  imageView.image = image;
  imageView.contentMode = UIViewContentModeScaleAspectFill;
  imageView.clipsToBounds = true;
  imageView.layer.cornerRadius = 5.0;
  imageView.layer.borderWidth = 2.0;
  imageView.layer.borderColor = [UIColor grayColor].CGColor;
  [imageView setUserInteractionEnabled:YES];
  UITapGestureRecognizer
      *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
  [imageView addGestureRecognizer:tapGesture];
  tapGesture.view.tag = index;
  [self.contentView addSubview:imageView];
  [self.item.imageList addObject:imageView];
  [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(TEXT_MARGIN_LEFT + (self.item.imageList.count / 4 + 1) * self->viewHeight);
  }];
}

#pragma mark clickEvent
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

  if (actionSheet.tag == 0) {
    imagePicker.delegate = self;
    switch (buttonIndex) {
    case 0:imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
      [self.item.vc presentViewController:imagePicker animated:YES completion:^{}];
      break;
    case 1: {
      imagePicker.navigationBar.barStyle = UIBarStyleBlackOpaque;
      imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;

      [self.item.vc presentViewController:imagePicker animated:YES completion:^{
      }];
      break;

    }
    default:break;
    }

  } else if (actionSheet.tag >= 10) {
    if (buttonIndex == 0) {
      [self.item.imageList[(NSUInteger) (actionSheet.tag - 10)] removeFromSuperview];
      [self.item.imageList removeObjectAtIndex:(NSUInteger) (actionSheet.tag - 10)];
      [self updateImageListView];
    }
  }
}

- (void)updateImageListView {
  for (int i = 0; i < [self.item.imageList count]; i++) {
    [self updateImageView:self.item.imageList[(NSUInteger) i] index:(NSUInteger) i];
  }
  [self updatePickerButton:[self.item.imageList count]];
  [self mas_updateConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(TEXT_MARGIN_LEFT + (self.item.imageList.count / 4 + 1) * self->viewHeight);
  }];
}

- (void)addImage:(id)sender {
  //关闭键盘
  [kKeyWindow endEditing:YES];
//  if ([imageList count] >= _maxImageCount) {
//    [ViewUtils showHudTipStr:[NSString stringWithFormat:@"图片不能多于%d张哦", _maxImageCount]];
//    return;
//  }
  UIActionSheet *mySheet = [[UIActionSheet alloc]
               initWithTitle:@"图片选取"
                    delegate:self
           cancelButtonTitle:@"取消"
      destructiveButtonTitle:nil
           otherButtonTitles:@"拍照上传", @"相册选取", nil];

  mySheet.tag = 0;
  [mySheet showInView:self];
}

- (void)clickImage:(id)sender {
  UITapGestureRecognizer *tap = (UITapGestureRecognizer *) sender;
  UIActionSheet *mySheet = [[UIActionSheet alloc] initWithTitle:@"图片选取" delegate:self cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"删除图片", nil];
  mySheet.tag = 10 + tap.view.tag;
  [mySheet showInView:self];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [picker dismissViewControllerAnimated:YES completion:^{
  }];

  UIImage *image = info[UIImagePickerControllerOriginalImage];
  UIImage *cImage = [self imageCompress:image];

  [self addImageCell:[self.item.imageList count] image:cImage];
  [self updatePickerButton:[self.item.imageList count]];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [picker dismissViewControllerAnimated:YES completion:^{

  }];
}

//压缩图片  max-height： 1000 max-width: 1000
- (UIImage *)imageCompress:(UIImage *)sourceImage {
  CGFloat maxHeight = 1000;
  CGFloat maxWidth = 1000;
  CGFloat targetWidth = 0;
  CGFloat targetHeight = 0;
  CGSize imageSize = sourceImage.size;
  CGFloat width = imageSize.width;
  CGFloat height = imageSize.height;
  if (height > maxHeight) {
    targetHeight = maxHeight;
    targetWidth = (targetHeight * width) / height;
  } else {
    targetHeight = height;
    targetWidth = width;
  }

  if (targetWidth > maxWidth) {
    targetWidth = maxWidth;
    targetHeight = (height * targetWidth) / width;
  }

  UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
  [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

- (NSArray *)getImageList {
  NSMutableArray *images = [[NSMutableArray alloc] init];
  for (UIImageView *imageView in self.item.imageList) {
    [images addObject:imageView.image];
  }
  return images;
}

@end
