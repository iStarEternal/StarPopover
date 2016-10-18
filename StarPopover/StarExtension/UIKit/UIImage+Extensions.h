//
//  UIImage+Extensions.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/6/12.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)

+ (instancetype)imageWithColor:(UIColor *)color;

- (UIColor *)colorWithCreatedImage;

- (UIColor *)colorWithPoint:(CGPoint)point;

- (UIImage *)imageWithBrightness:(CGFloat)brightness;

@end


@interface StarImageCache : NSObject

+ (instancetype)sharedCache;

- (void)storeImage:(UIImage *)image forColor:(UIColor *)color;

- (UIImage *)imageWithContains:(UIColor *)color;

- (UIImage *)imageFromCacheForColor:(UIColor *)color;

@end