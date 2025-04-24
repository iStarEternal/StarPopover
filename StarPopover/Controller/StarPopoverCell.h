//
//  StarPopoverCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/6/21.
//  Copyright © 2016年 SinaPay. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface StarPopoverCell : UITableViewCell

@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, weak) UIView *wex_separator;

@property (nonatomic, assign, getter=isSeparatorHidden) BOOL separatorHidden; // Default is true
@property (nonatomic, assign) UIEdgeInsets separatorEdgeInset; // Default: top is invalid, left is 15, bottom is 0, right is 0
@end
