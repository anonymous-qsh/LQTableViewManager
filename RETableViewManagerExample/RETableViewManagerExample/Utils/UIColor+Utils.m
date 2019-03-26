//
//  UIColor+Utils.m
//
//  Created by wangweilong on 15/12/30.
//  Copyright © 2015年 wangweilong. All rights reserved.
//

#import "UIColor+Utils.h"

@implementation UIColor (Utils)



+ (UIColor *) stringToColor:(NSString *)str {
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

+ (UIColor *) stringToColor:(NSString *)str andAlpha:(float)alpha{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
    return color;
}

+ (UIColor*) mainColor{
    return [UIColor stringToColor: @"#FB8641"];
}

+ (UIColor*) separatorColor{
    return [UIColor stringToColor:@"#eeeeee"];
}

+ (UIColor*) separatorLineDarkColor{
    return [UIColor stringToColor:@"#cccccc"];
}

+ (UIColor*) separatorLineLightColor{
    return [UIColor stringToColor:@"#f7f7f7"];
}

+ (UIColor*) contentBackgroundColor{
    return [UIColor whiteColor];
}

+ (UIColor*) titleColor{
    return [UIColor stringToColor:@"#000000"];
}


+ (UIColor*) contentDarkColor{
    return [UIColor stringToColor:@"#333333"];
}


+ (UIColor*) contentLightColor{
    return [UIColor stringToColor:@"#757575"];
}


+ (UIColor*) iconLightColor{
    return [UIColor stringToColor:@"#9b9b9b"];
}

+ (UIColor *) riseRankColor{
    return [UIColor stringToColor:@"#39a9cc"];
}
+ (UIColor *) btnStartColor{
    return [UIColor stringToColor:@"#F3AF49"];
}
+ (UIColor *) btnEndColor{
    return [UIColor stringToColor:@"#F78841"];
}



+ (UIColor *) reColor{
    return [UIColor stringToColor:@"#39a9cc"];
}

+(UIColor *)selectedColor{
    return [UIColor stringToColor:@"#eb4f38"];
}

+(UIColor *) TopicCommentNameColor{
    return [UIColor stringToColor:@"#576b95"];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha{
    UIColor *color = [UIColor colorWithHexString:stringToConvert];
    
    return [UIColor colorWithRed:color.red green:color.green blue:color.blue alpha:alpha];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}




- (CGFloat)red {
    //NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green {
    //NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)blue {
    //NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}
- (CGColorSpaceModel)colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

@end
