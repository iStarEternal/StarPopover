//
//  StarPopover.h
//  StarPopover
//
//  Created by 星星 on 15/11/16.
//  Copyright © 2015年 Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarPopover;

typedef NS_OPTIONS(NSUInteger, StarPopoverPosition) {
    StarPopoverPositionUp    = 1,
    StarPopoverPositionDown  = 1 << 1,
    StarPopoverPositionLeft  = 1 << 2,
    StarPopoverPositionRight = 1 << 3
};

typedef NS_ENUM(NSUInteger, StarPopoverMaskType) {
    StarPopoverMaskTypeBlack,
    StarPopoverMaskTypeNone
};

@protocol StarPopoverDelegate <NSObject>

@optional

/**
 *  是否允许关闭Popover 若不实现该代理，则默认return true
 *  @return 是否允许关闭Popover
 */
- (BOOL)starPopoverShouldDismissPopover:(StarPopover *)popover;
/**
 *  Popover被关闭后执行
 *  @param force    是否是主动关闭的
 */
- (void)starPopover:(StarPopover *)popopver didDismissWithForce:(BOOL)force;

@end


@interface StarPopover : UIView

+ (instancetype)popover;

/**
 *  Popover代理
 */
@property (nonatomic, weak) id<StarPopoverDelegate> delegate;

/**
 *  背景层遮盖
 */
@property (nonatomic, strong) UIControl *blackOverlay;

/**
 *  弹出方向 以后支持或多面弹出
 */
@property (nonatomic, assign, readonly) StarPopoverPosition popoverPosition;

/**
 *  箭头大小, 默认值 {10.0, 10.0}
 */
@property (nonatomic, assign) CGSize arrowSize;

/**
 *  圆角半径, 默认值 7.0
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 *  显示动画时间, 默认值 0.4
 */
@property (nonatomic, assign) CGFloat animationIn;

/**
 *  消散动画时间, 默认值 0.3
 */
@property (nonatomic, assign) CGFloat animationOut;

/**
 *  弹簧效果, 默认值 YES
 */
@property (nonatomic, assign) BOOL animationSpring;

/**
 *  背景遮盖, 默认值 StarPopoverMaskTypeBlack
 */
@property (nonatomic, assign) StarPopoverMaskType maskType;

/**
 *  阴影开关，默认值 YES
 *  如果你想自定义阴影，你可以设置 popover.layer.shadowColor, shadowOffset, shadowOpacity, shadowRadius
 */
@property (nonatomic, assign) BOOL applyShadow;

/**
 *  弹出点与箭头的间隔
 */
@property (nonatomic, assign) CGFloat betweenAtViewAndArrowHeight;


/**
 * Popover 距离边缘的尺寸, 默认值是 10.0
 */
@property (nonatomic, assign) CGFloat sideEdge;


/**
 *  是否显示在屏幕上
 */
@property (nonatomic, assign, readonly) BOOL showInScreen;


#pragma mark - Show in View

- (void)showAtPoint:(CGPoint)point popoverPostion:(StarPopoverPosition)position withContentView:(UIView *)contentView inView:(UIView *)containerView;

- (void)showAtView:(UIView *)atView popoverPostion:(StarPopoverPosition)position withContentView:(UIView *)contentView inView:(UIView *)containerView;

- (void)showAtView:(UIView *)atView withContentView:(UIView *)contentView inView:(UIView *)containerView;

- (void)showAtView:(UIView *)atView withContentView:(UIView *)contentView;


#pragma mark - Show in Controller

- (void)showAtPoint:(CGPoint)point popoverPostion:(StarPopoverPosition)position withContentViewController:(UIViewController*)viewController inView:(UIView *)containerView;

- (void)showAtPoint:(CGPoint)point popoverPostion:(StarPopoverPosition)position withContentViewController:(UIViewController *)viewController;

- (void)showAtView:(UIView *)atView popoverPostion:(StarPopoverPosition)position withContentViewController:(UIViewController*)viewController inView:(UIView *)containerView;

- (void)showAtView:(UIView *)atView withContentViewController:(UIViewController *)viewController inView:(UIView *)containerView;

- (void)showAtView:(UIView *)atView withContentViewController:(UIViewController *)viewController;


#pragma mark - Show in UIBarButtonItem

- (void)showAtBarButtonItem:(UIBarButtonItem *)atView withContentViewController:(UIViewController*)viewController;


#pragma mark - Dismiss

/**
 *  主动关闭StarPopover
 */
- (void)dismiss;


@end
