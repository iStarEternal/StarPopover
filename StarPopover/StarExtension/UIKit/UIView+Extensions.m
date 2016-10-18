//
//  UIView+Extensions.m
//  Star
//
//  Created by 星星 on 16/3/21.
//  Copyright © 2016年 Star. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView(Frame)


- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect newFrame = self.frame;
    newFrame.origin.x = x;
    self.frame = newFrame;
}


- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect newFrame = self.frame;
    newFrame.origin.y = y;
    self.frame = newFrame;
}


- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    self.frame = newFrame;
}


- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
}


- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint newCenter = self.center;
    newCenter.x = centerX;
    self.center = newCenter;
}


- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint newCenter = self.center;
    newCenter.y = centerY;
    self.center = newCenter;
}

- (CGPoint)boundsCenter {
    return CGPointMake(self.width / 2, self.height / 2);
}


- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)maxX {
    
    CGRect f = self.frame;
    f.origin.x = maxX - f.size.width;
    self.frame = f;
}


- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY {
    
    CGRect f = self.frame;
    f.origin.y = maxY - f.size.height;
    self.frame = f;
}


- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect f = self.frame;
    f.size = size;
    self.frame = f;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect f = self.frame;
    f.origin = origin;
    self.frame = f;
}


@end


@implementation UIView (Hierarchy)


- (void)bringToFront {
    [self.superview bringSubviewToFront:self];
}

- (void)sendToBack {
    [self.superview sendSubviewToBack:self];
}

- (void)removeSubview:(UIView *)view {
    if ([self.subviews containsObject:view]) {
        [view removeFromSuperview];
    }
}

- (void)removeAllSubviews {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

@end