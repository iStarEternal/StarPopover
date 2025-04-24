//
//  StarPopoverViewController.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/29.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarPopoverViewController;

@protocol StarPopoverViewControllerDelegate <NSObject>

@optional
- (void)popoverViewController:(StarPopoverViewController *)viewController didSelectRowAtIndex:(NSInteger)index;

@end


@interface StarPopoverViewController : UITableViewController

@property (nonatomic, weak) id<StarPopoverViewControllerDelegate> delegate;

@property (nonatomic, copy) NSArray<NSString *> *titles;

@property (nonatomic, assign) NSInteger currentSelectedIndex;

/**
 *  默认值 40
 */
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, copy) UIColor *selectedColor;
@property (nonatomic, copy) UIColor *normalColor;


- (instancetype)initWithTitles:(NSArray<NSString *> *)titles;

@end
