//
//  StarPopover.m
//  StarPopover
//
//  Created by 星星 on 15/11/16.
//  Copyright © 2015年 Star. All rights reserved.
//

#import "StarPopover.h"

#define DEGREES_TO_RADIANS(degrees)  ((3.14159265359 * (degrees)) / 180)

@interface StarPopover ()

@property (nonatomic, assign) CGRect contentViewFrame;
@property (nonatomic, assign) StarPopoverPosition popoverPosition;
@property (nonatomic, assign) CGPoint arrowShowPoint;

/** 弹出的View */
@property (nonatomic, weak) UIView *contentView;

/** 弹出的控制器 */
@property (nonatomic, strong) UIViewController *contentViewController;

/** 装载弹出内容的容器 */
@property (nonatomic, weak) UIView *containerView;

@end


@implementation StarPopover

#pragma mark - 构造函数

+ (instancetype)popover {
    return [[self alloc] init];
}

+ (instancetype)shared {
    static StarPopover *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [StarPopover popover];
    });
    return instance;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectZero]) {
        self.arrowSize = CGSizeMake(11.0, 9.0);
        self.cornerRadius = 7.0;
        self.backgroundColor = [UIColor clearColor];
        self.animationIn = 0.4;
        self.animationOut = 0.3;
        self.animationSpring = true;
        self.sideEdge = 10.0;
        self.maskType = StarPopoverMaskTypeBlack;
        self.betweenAtViewAndArrowSpace = 4.0;
        self.applyShadow = true;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"Popover Dealloc");
}


#pragma mark - Show ViewController

- (void)showAtPoint:(CGPoint)point
     popoverPostion:(StarPopoverPosition)position
withContentViewController:(UIViewController *)viewController
             inView:(UIView *)containerView {
    self.contentViewController = viewController;
    self.contentViewController.view.frame = CGRectMake(0, 0, viewController.preferredContentSize.width, viewController.preferredContentSize.height);
    [self showAtPoint:point popoverPostion:position withContentView:viewController.view inView:containerView];
}

- (void)showAtPoint:(CGPoint)point
     popoverPostion:(StarPopoverPosition)position
withContentViewController:(UIViewController *)viewController {
    self.contentViewController = viewController;
    self.contentViewController.view.frame = CGRectMake(0, 0, viewController.preferredContentSize.width, viewController.preferredContentSize.height);
    [self showAtPoint:point popoverPostion:position withContentView:viewController.view inView:[UIApplication sharedApplication].keyWindow];
}

- (void)showAtView:(UIView *)atView
    popoverPostion:(StarPopoverPosition)position
withContentViewController:(UIViewController *)viewController
            inView:(UIView *)containerView {
    self.contentViewController = viewController;
    self.contentViewController.view.frame = CGRectMake(0, 0, viewController.preferredContentSize.width, viewController.preferredContentSize.height);
    [self showAtView:atView popoverPostion:position withContentView:viewController.view inView:containerView];
}

- (void)showAtView:(UIView *)atView
withContentViewController:(UIViewController *)viewController
            inView:(UIView *)containerView {
    self.contentViewController = viewController;
    self.contentViewController.view.frame = CGRectMake(0, 0, viewController.preferredContentSize.width, viewController.preferredContentSize.height);
    [self showAtView:atView withContentView:viewController.view inView:containerView];
}

- (void)showAtView:(UIView *)atView
withContentViewController:(UIViewController *)viewController {
    self.contentViewController = viewController;
    self.contentViewController.view.frame = CGRectMake(0, 0, viewController.preferredContentSize.width, viewController.preferredContentSize.height);
    [self showAtView:atView withContentView:viewController.view];
}


#pragma mark - Show in UIBarButtonItem

- (void)showAtBarButtonItem:(UIBarButtonItem *)atView
  withContentViewController:(UIViewController *)viewController {
    self.contentViewController = viewController;
    self.contentViewController.view.frame = CGRectMake(0, 0, viewController.preferredContentSize.width, viewController.preferredContentSize.height);
    
    UIView *view = [atView performSelector:@selector(view)];
    [self showAtView:view popoverPostion:0 withContentView:viewController.view inView:[UIApplication sharedApplication].keyWindow];
}


#pragma mark - Show in View

- (void)showAtView:(UIView *)atView
    popoverPostion:(StarPopoverPosition)position
   withContentView:(UIView *)contentView
            inView:(UIView *)containerView {
    
    CGFloat betweenAtViewAndArrow = self.betweenAtViewAndArrowSpace;
    CGFloat contentViewHeight = CGRectGetHeight(contentView.bounds);
    CGRect atViewFrame = [atView convertRect:CGRectMake(0, 0, atView.frame.size.width, atView.frame.size.height) toView:containerView];
    
    BOOL upCanContain = CGRectGetMinY(atViewFrame) >= contentViewHeight + betweenAtViewAndArrow;
    BOOL downCanContain = (CGRectGetHeight(containerView.bounds) - (CGRectGetMaxY(atViewFrame)+betweenAtViewAndArrow)) >= contentViewHeight;
    NSAssert((upCanContain || downCanContain), @"StarPopover no place for the popover show, check atView frame %@ check contentView bounds %@ and containerView's bounds %@", NSStringFromCGRect(atViewFrame), NSStringFromCGRect(contentView.bounds), NSStringFromCGRect(containerView.bounds));
    
    
    CGPoint atPoint = CGPointMake(CGRectGetMidX(atViewFrame), 0);
    StarPopoverPosition dxP;
    if (upCanContain) {
        dxP = StarPopoverPositionUp;
        atPoint.y = CGRectGetMinY(atViewFrame) - betweenAtViewAndArrow;
    }
    else {
        dxP = StarPopoverPositionDown;
        atPoint.y = CGRectGetMaxY(atViewFrame) + betweenAtViewAndArrow;
    }
    
    if (upCanContain && downCanContain) {
        CGFloat upHeight = CGRectGetMinY(atViewFrame);
        CGFloat downHeight = CGRectGetHeight(containerView.bounds)-CGRectGetMaxY(atViewFrame);
        BOOL useUp = upHeight > downHeight;
        
        if (position != 0) {
            useUp = position == StarPopoverPositionUp ? true : false;
        }
        if (useUp) {
            dxP = StarPopoverPositionUp;
            atPoint.y = CGRectGetMinY(atViewFrame) - betweenAtViewAndArrow;
        }
        else {
            dxP = StarPopoverPositionDown;
            atPoint.y = CGRectGetMaxY(atViewFrame) + betweenAtViewAndArrow;
        }
    }
    
    [self showAtPoint:atPoint popoverPostion:dxP withContentView:contentView inView:containerView];
}

- (void)showAtView:(UIView *)atView
   withContentView:(UIView *)contentView
            inView:(UIView *)containerView {
    [self showAtView:atView popoverPostion:0 withContentView:contentView inView:containerView];
}

- (void)showAtView:(UIView *)atView
   withContentView:(UIView *)contentView {
    [self showAtView:atView withContentView:contentView inView:[UIApplication sharedApplication].keyWindow];
}

- (void)showAtPoint:(CGPoint)point
     popoverPostion:(StarPopoverPosition)position
    withContentView:(UIView *)contentView
             inView:(UIView *)containerView {
    
    NSAssert((CGRectGetWidth(contentView.bounds) > 0 && CGRectGetHeight(contentView.bounds) > 0), @"StarPopover contentView bounds.size should not be zero");
    NSAssert((CGRectGetWidth(containerView.bounds) > 0 && CGRectGetHeight(containerView.bounds) > 0), @"StarPopover containerView bounds.size should not be zero");
    NSAssert(CGRectGetWidth(containerView.bounds) >= CGRectGetWidth(contentView.bounds), @"StarPopover containerView width should be wider than contentView width");
    
    
    self.containerView = containerView;
    self.contentView = contentView;
    self.contentView.layer.cornerRadius = self.cornerRadius;
    self.contentView.layer.masksToBounds = true;
    self.popoverPosition = position;
    self.arrowShowPoint = point;
    self.contentViewFrame = [containerView convertRect:contentView.frame toView:containerView];
    
    [self setupOverlay];
    [self show];
}


#pragma mark - Setter

- (void)setArrowShowPoint:(CGPoint)arrowShowPoint {
    _arrowShowPoint = arrowShowPoint;
    [self setNeedsDisplay];
}

- (void)setApplyShadow:(BOOL)applyShadow {
    _applyShadow = applyShadow;
    if (_applyShadow) {
        self.layer.shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowRadius = 2.0;
    }
    else {
        self.layer.shadowColor = nil;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.0;
        self.layer.shadowRadius = 0.0;
    }
}


#pragma mark - Handler

- (void)handleDismiss:(id)sender {
    [self dismiss:false];
}

// 设置背景遮盖
- (void)setupOverlay {
    
    if (!self.blackOverlay) {
        self.blackOverlay = [[UIControl alloc] init];
        self.blackOverlay.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    [self.containerView addSubview:self.blackOverlay];
    self.blackOverlay.frame = self.containerView.bounds;
    self.blackOverlay.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [self.blackOverlay addTarget:self action:@selector(handleDismiss:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat alpha = 0;
    switch (self.maskType) {
        case StarPopoverMaskTypeBlack:
            alpha = 0.2;
            break;
        case StarPopoverMaskTypeNone:
            alpha = 0;
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.blackOverlay.backgroundColor = [UIColor colorWithWhite:0.0 alpha:alpha];
    }];
    
}

- (void)show {
    self.frame = CGRectZero;
    // [self setNeedsDisplay];
    
    CGRect contentViewFrame = self.contentViewFrame;
    switch (self.popoverPosition) {
        case StarPopoverPositionUp:
            contentViewFrame.origin.y = 0.0;
            break;
        case StarPopoverPositionDown:
            contentViewFrame.origin.y = self.arrowSize.height;
            break;
        case StarPopoverPositionLeft:
            contentViewFrame.origin.x = 0.0;
            break;
        case StarPopoverPositionRight:
            contentViewFrame.origin.x = self.arrowSize.height;
            break;
    }
    
    [self addSubview:self.contentView];
    self.contentView.frame = contentViewFrame;
    
    [self.containerView addSubview:self];
    
    self.hidden = false;
    self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    if (self.animationSpring) {
        [UIView animateWithDuration:self.animationIn delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                _showInScreen = true;
            }
        }];
    }
    else {
        [UIView animateWithDuration:self.animationIn delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                _showInScreen = true;
            }
        }];
    }
}

- (void)dismiss {
    [self dismiss: true];
}
/**
 *  关闭Popover
 *
 *  @param force   YES: 调用-[StarPopover dismiss]关闭, NO: 点击空白区域关闭
 */
- (void)dismiss:(BOOL)force {
    
    if (self.superview) {
        
        if ([self.delegate respondsToSelector:@selector(starPopoverShouldDismissPopover:)]) {
            if (![self.delegate starPopoverShouldDismissPopover:self]) {
                return;
            }
        }
        
        [self endEditing:true];
        [UIView animateWithDuration:self.animationOut delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
            self.hidden = true;
            self.blackOverlay.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        } completion:^(BOOL finished) {
            if (finished) {
                
                _showInScreen = false;
                [self.blackOverlay removeFromSuperview];
                [self.contentView removeFromSuperview];
                self.contentViewController = nil;
                [self removeFromSuperview];
                [self endEditing:true];
                
                if ([self.delegate respondsToSelector:@selector(starPopover:didDismissWithForce:)]) {
                    [self.delegate starPopover:self didDismissWithForce:force];
                }
            }
        }];
    }
    else {
        [self.blackOverlay removeFromSuperview];
    }
}

#pragma mark - 布局


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = self.contentViewFrame;
    
    CGFloat frameMidX = self.arrowShowPoint.x - CGRectGetWidth(frame) * 0.5;
    frame.origin.x = frameMidX;
    
    CGFloat frameMidY = self.arrowShowPoint.y - CGRectGetHeight(frame) * 0.5;
    frame.origin.y = frameMidY;
    
    
    CGFloat sideEdgeX = 0.0;
    if (CGRectGetWidth(frame) < CGRectGetWidth(self.containerView.frame)) {
        sideEdgeX = self.sideEdge;
    }
    
    CGFloat sideEdgeY = 0.0;
    if (CGRectGetHeight(frame) < CGRectGetHeight(self.containerView.frame)) {
        sideEdgeY = self.sideEdge;
    }
    
    CGFloat outerSideEdgeX = CGRectGetMaxX(frame) - CGRectGetWidth(self.containerView.bounds);
    if (outerSideEdgeX > 0) {
        frame.origin.x -= (outerSideEdgeX + sideEdgeX);
    }
    else {
        if (CGRectGetMinX(frame)<0) {
            frame.origin.x += fabs(CGRectGetMinX(frame)) + sideEdgeX;
        }
    }
    
    CGFloat outerSideEdgeY = CGRectGetMaxY(frame) - CGRectGetHeight(self.containerView.bounds);
    if (outerSideEdgeY > 0) {
        frame.origin.y -= (outerSideEdgeY + sideEdgeY);
    }
    else {
        if (CGRectGetMinY(frame) < 0) {
            frame.origin.y += fabs(CGRectGetMinY(frame)) + sideEdgeY;
        }
    }
    
    // 目前发现的特殊案例，在iOS8.3一下的机器无法兼容这一句代码
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        self.frame = frame;
    }
    
    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowShowPoint toView:self];
    
    CGPoint anchorPoint;
    switch (self.popoverPosition) {
        case StarPopoverPositionDown: {
            frame.origin.y = self.arrowShowPoint.y;
            anchorPoint = CGPointMake(arrowPoint.x / CGRectGetWidth(frame), 0);
            frame.size.height += self.arrowSize.height;
        }
            break;
        case StarPopoverPositionUp: {
            frame.origin.y = self.arrowShowPoint.y - CGRectGetHeight(frame) - self.arrowSize.height;
            anchorPoint = CGPointMake(arrowPoint.x / CGRectGetWidth(frame), 1);
            frame.size.height += self.arrowSize.height;
        }
            break;
        case StarPopoverPositionRight: {
            frame.origin.x = self.arrowShowPoint.x;
            anchorPoint = CGPointMake(0, arrowPoint.y / CGRectGetHeight(frame));
            frame.size.width += self.arrowSize.height;
        }
            break;
        case StarPopoverPositionLeft: {
            frame.origin.x = self.arrowShowPoint.x - CGRectGetWidth(frame) - self.arrowSize.height;
            anchorPoint = CGPointMake(1, arrowPoint.y / CGRectGetHeight(frame));
            frame.size.width += self.arrowSize.height;
        }
            break;
    }
    CGPoint lastAnchor = self.layer.anchorPoint;
    self.layer.anchorPoint = anchorPoint;
    self.layer.position = CGPointMake(self.layer.position.x + (anchorPoint.x - lastAnchor.x) * self.layer.bounds.size.width, self.layer.position.y + (anchorPoint.y - lastAnchor.y) * self.layer.bounds.size.height);
    
    
    self.frame = frame;
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentViewFrame.size.width, self.contentViewFrame.size.height);
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *bubble = [[UIBezierPath alloc] init];
    CGPoint arrowPoint = [self.containerView convertPoint:self.arrowShowPoint toView:self];
    
    /*  绘制气泡
     *  顶角顺序如下:
     *  4   1
     *
     *  3   2
     */
    switch (self.popoverPosition) {
        case StarPopoverPositionDown: {
            [bubble moveToPoint:CGPointMake(arrowPoint.x, 0)];
            [bubble addLineToPoint:CGPointMake(arrowPoint.x + self.arrowSize.width * 0.5, self.arrowSize.height)];
            
            // 1
            [bubble addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - self.cornerRadius, self.arrowSize.height)];
            [bubble addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - self.cornerRadius, self.arrowSize.height + self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(270.0) endAngle:DEGREES_TO_RADIANS(0) clockwise:true];
            // 2
            [bubble addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - self.cornerRadius)];
            [bubble addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - self.cornerRadius, CGRectGetHeight(self.bounds) - self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90.0) clockwise:true];
            // 3
            [bubble addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
            [bubble addArcWithCenter:CGPointMake(self.cornerRadius, CGRectGetHeight(self.bounds) - self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(180.0) clockwise:true];
            // 4
            [bubble addLineToPoint:CGPointMake(0, self.arrowSize.height + self.cornerRadius)];
            [bubble addArcWithCenter:CGPointMake(self.cornerRadius, self.arrowSize.height + self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(180.0) endAngle:DEGREES_TO_RADIANS(270) clockwise:true];
            
            [bubble addLineToPoint:CGPointMake(arrowPoint.x - self.arrowSize.width * 0.5, self.arrowSize.height)];
        }
            break;
        case StarPopoverPositionUp: {
            [bubble moveToPoint:CGPointMake(arrowPoint.x, CGRectGetHeight(self.bounds))];
            [bubble addLineToPoint:CGPointMake(arrowPoint.x-self.arrowSize.width * 0.5, CGRectGetHeight(self.bounds) - self.arrowSize.height)];
            
            // 3
            [bubble addLineToPoint:CGPointMake(self.cornerRadius, CGRectGetHeight(self.bounds) - self.arrowSize.height)];
            [bubble addArcWithCenter:CGPointMake(self.cornerRadius, CGRectGetHeight(self.bounds) - self.arrowSize.height - self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(90.0) endAngle:DEGREES_TO_RADIANS(180.0) clockwise:true];
            // 4
            [bubble addLineToPoint:CGPointMake(0, self.cornerRadius)];
            [bubble addArcWithCenter:CGPointMake(self.cornerRadius, self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(180.0) endAngle:DEGREES_TO_RADIANS(270.0) clockwise:true];
            // 1
            [bubble addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - self.cornerRadius, 0)];
            [bubble addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - self.cornerRadius, self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(270.0) endAngle:DEGREES_TO_RADIANS(0) clockwise:true];
            // 2
            [bubble addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-self.arrowSize.height-self.cornerRadius)];
            [bubble addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - self.cornerRadius, CGRectGetHeight(self.bounds)-self.arrowSize.height-self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90.0) clockwise:true];
            
            [bubble addLineToPoint:CGPointMake(arrowPoint.x+self.arrowSize.width*0.5, CGRectGetHeight(self.bounds)-self.arrowSize.height)];
        }
            break;
        case StarPopoverPositionRight: {
            [bubble moveToPoint:CGPointMake(0, arrowPoint.y)];
            [bubble addLineToPoint:CGPointMake(self.arrowSize.height, arrowPoint.y - self.arrowSize.width * 0.5)];
            
            // 4
            [bubble addLineToPoint:CGPointMake(self.arrowSize.height, self.cornerRadius)];
            [bubble addArcWithCenter:CGPointMake(self.cornerRadius + self.arrowSize.height, self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(180.0) endAngle:DEGREES_TO_RADIANS(270) clockwise:true];
            
            // 1
            [bubble addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - self.cornerRadius , 0)];
            [bubble addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - self.cornerRadius , self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(270.0) endAngle:DEGREES_TO_RADIANS(0) clockwise:true];
            
            // 2
            [bubble addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - self.cornerRadius)];
            [bubble addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - self.cornerRadius, CGRectGetHeight(self.bounds) - self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90.0) clockwise:true];
            
            // 3
            [bubble addLineToPoint:CGPointMake(self.arrowSize.height, CGRectGetHeight(self.bounds))];
            [bubble addArcWithCenter:CGPointMake(self.cornerRadius + self.arrowSize.height, CGRectGetHeight(self.bounds) - self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(180.0) clockwise:true];
            
            [bubble addLineToPoint:CGPointMake(self.arrowSize.height, arrowPoint.y + self.arrowSize.width * 0.5)];
        }
            break;
        case StarPopoverPositionLeft: {
            [bubble moveToPoint:CGPointMake(CGRectGetWidth(self.bounds), arrowPoint.y)];
            [bubble addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - self.arrowSize.height, arrowPoint.y + self.arrowSize.width * 0.5)];
            
            // 2
            [bubble addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - self.arrowSize.height, CGRectGetHeight(self.bounds) - self.cornerRadius)];
            [bubble addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - self.arrowSize.height - self.cornerRadius, CGRectGetHeight(self.bounds) - self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(90.0) clockwise:true];
            // 3
            [bubble addLineToPoint:CGPointMake(0, CGRectGetHeight(self.bounds))];
            [bubble addArcWithCenter:CGPointMake(self.cornerRadius, CGRectGetHeight(self.bounds) - self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(90) endAngle:DEGREES_TO_RADIANS(180.0) clockwise:true];
            // 4
            [bubble addLineToPoint:CGPointMake(0, self.cornerRadius)];
            [bubble addArcWithCenter:CGPointMake(self.cornerRadius, self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(180.0) endAngle:DEGREES_TO_RADIANS(270) clockwise:true];
            // 1
            [bubble addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - self.arrowSize.height - self.cornerRadius , 0)];
            [bubble addArcWithCenter:CGPointMake(CGRectGetWidth(self.bounds) - self.arrowSize.height - self.cornerRadius , self.cornerRadius) radius:self.cornerRadius startAngle:DEGREES_TO_RADIANS(270.0) endAngle:DEGREES_TO_RADIANS(0) clockwise:true];
            
            [bubble addLineToPoint:CGPointMake(CGRectGetWidth(self.bounds) - self.arrowSize.height, arrowPoint.y - self.arrowSize.width * 0.5)];
        }
            break;
    }
    UIColor *contentColor = self.contentView.backgroundColor ? : [UIColor whiteColor];
    [contentColor setFill];
    [bubble fill];
}



@end
