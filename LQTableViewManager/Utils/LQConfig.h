//
//  LQConfig.h
//  Pods
//
//  Created by LittleQ on 2019/3/29.
//

#ifndef LQConfig_h
#define LQConfig_h

#ifndef ScreenWidth
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

#ifndef ScreenHeight
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#endif

#define PhotoBrowseBackgroundAlpha 1.f
#define PhotoBrowseBrowseTime      .3f
#define PhotoBrowseMargin          20.f

// photo max scale
#define PhotoBrowseImageMaxScale   2.f
// photo min scale
#define PhotoBrowseImageMinScale   1.f

#define PhotoSaveImageSuccessMessage  @"^_^ 保存成功!!"
#define PhotoSaveImageFailureMessage @"/(ㄒoㄒ)/~~ 保存失败!!"
#define PhotoSaveImageMessageTime    2
#define PhotoSaveImageFailureReason  @"图片需要下载完成"
#define PhotoShowPlaceHolderImageColor [UIColor blackColor]

#endif /* LQConfig_h */
