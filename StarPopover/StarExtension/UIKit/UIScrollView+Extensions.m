//
//  UITableView+Extensions.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/19.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "UIScrollView+Extensions.h"

@implementation UIScrollView(Extensions)

- (CGFloat)contentInsetLeft {
    return self.contentInset.left;
}

- (void)setContentInsetLeft:(CGFloat)contentInsetLeft {
    UIEdgeInsets inset = self.contentInset;
    inset.left = contentInsetLeft;
    self.contentInset = inset;
}

- (CGFloat)contentInsetRight {
    return self.contentInset.right;
}

- (void)setContentInsetRight:(CGFloat)contentInsetRight {
    UIEdgeInsets inset = self.contentInset;
    inset.right = contentInsetRight;
    self.contentInset = inset;
}

- (CGFloat)contentInsetTop {
    return self.contentInset.top;
}

- (void)setContentInsetTop:(CGFloat)contentInsetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = contentInsetTop;
    self.contentInset = inset;
}

- (CGFloat)contentInsetBottom {
    return self.contentInset.bottom;
}

- (void)setContentInsetBottom:(CGFloat)contentInsetBottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = contentInsetBottom;
    self.contentInset = inset;
}


@end
