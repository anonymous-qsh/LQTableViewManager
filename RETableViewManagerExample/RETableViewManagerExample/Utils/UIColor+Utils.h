//
//  UIColor+Utils.h
//  qducc_ios
//
//  Created by wangweilong on 15/12/30.
//  Copyright © 2015年 wangweilong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utils)

+ (UIColor *) stringToColor:(NSString *)str;
+ (UIColor *) stringToColor:(NSString *)str andAlpha:(float)alpha;

+ (UIColor *) mainColor;
+ (UIColor*) separatorColor;
+ (UIColor*) separatorLineDarkColor;
+ (UIColor*) separatorLineLightColor;
+ (UIColor*) contentBackgroundColor;
+ (UIColor*) titleColor;
+ (UIColor*) contentDarkColor;
+ (UIColor*) contentLightColor;
+ (UIColor*) iconLightColor;
+ (UIColor *) riseRankColor;
+ (UIColor *) btnStartColor;
+ (UIColor *) btnEndColor;
+(UIColor *)selectedColor;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;
+(UIColor *) TopicCommentNameColor;

@end
