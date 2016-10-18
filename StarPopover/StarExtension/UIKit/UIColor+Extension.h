//
//  UIColor+Extension.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/6.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(Extension)

+ (instancetype)colorWithRGB:(NSInteger)rgb;

+ (instancetype)colorWithRGB:(NSInteger)rgb alpha:(CGFloat)alpha;

+ (instancetype)colorWithRGBA:(NSInteger)rgba;

+ (instancetype)tempColor;

+ (instancetype)randomColor;

- (NSInteger)rgba;

- (BOOL)isEqualToColor:(UIColor *)color;

@end
