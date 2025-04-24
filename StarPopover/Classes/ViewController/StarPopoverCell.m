//
//  StarPopoverCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/6/21.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "StarPopoverCell.h"
#import <Masonry/Masonry.h>

@interface StarPopoverCell ()
{}

@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *titleLabel;


@end

@implementation StarPopoverCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self wex_loadViews];
        [self wex_layoutConstraints];
#ifdef TEMP_COLOR
        [self wex_setupTempColor];
#endif
    }
    return self;
}

- (void)awakeFromNib {
    [self wex_loadViews];
    [self wex_layoutConstraints];
#ifdef TEMP_COLOR
    [self wex_setupTempColor];
#endif
    [super awakeFromNib];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    self.titleLabel.textColor = highlighted ? self.selectedTitleColor : self.titleColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.titleLabel.textColor = selected ? self.selectedTitleColor : self.titleColor;
}

- (void)wex_loadViews {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:iconView];
    self.iconView = iconView;
    self.iconView.hidden = true;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    
    UIView *wex_separator = [[UIView alloc] init];
    [self.contentView addSubview:wex_separator];
    self.wex_separator = wex_separator;
    self.wex_separator.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.7];
    _separatorEdgeInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [self.wex_separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.separatorEdgeInset.left);
        make.right.mas_equalTo(-self.separatorEdgeInset.right);
        make.bottom.mas_equalTo(-self.separatorEdgeInset.bottom);
        make.height.mas_equalTo(0.5).priorityHigh();
    }];
    
    self.separatorHidden = true;
}

- (void)wex_layoutConstraints {
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
}


- (UIImage *)icon {
    return self.iconView.image;
}

- (void)setIcon:(UIImage *)icon {
    self.iconView.image = icon;
    
    self.iconView.hidden = icon == nil;
    if (icon) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView).mas_equalTo(8);
            make.centerY.equalTo(0);
        }];
    }
    else {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
        }];
    }
}

- (NSString *)title {
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setSeparatorHidden:(BOOL)separatorHidden {
    self->_separatorHidden = separatorHidden;
    self.wex_separator.hidden = separatorHidden;
}

- (void)setSeparatorEdgeInset:(UIEdgeInsets)separatorEdgeInset {
    _separatorEdgeInset = separatorEdgeInset;
    [self.wex_separator mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(separatorEdgeInset.left);
        make.right.mas_equalTo(-separatorEdgeInset.right);
        make.bottom.mas_equalTo(-separatorEdgeInset.bottom);
    }];
}

@end
