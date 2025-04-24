//
//  StarPopoverViewController
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/29.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "StarPopoverViewController.h"
#import "StarPopoverCell.h"
#import "Masonry.h"

#define ContentCellReuseIdentifier @"Mark.By.Star.StarPopoverViewController.ContentCellIdentifier"

@interface StarPopoverViewController () <UITableViewDelegate>

@end

@implementation StarPopoverViewController


#pragma mark - 构造 & 析构

- (instancetype)init {
    self = [super init];
    if (self) {
        _cellHeight = 40;
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    self = [self init];
    if (self) {
        _titles = titles;
    }
    return self;
}

- (void)dealloc {
    NSLog(@"StarPopoverViewController Dealloc");
}


#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wex_loadViews];
    [self registerTableViewCell:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 页面构造

- (void)wex_loadViews {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (self.title) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, 0, 30);
        self.tableView.tableHeaderView = view;
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        label.font = [UIFont systemFontOfSize:13];
        label.text = self.title;
        [view addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.bottom.equalTo(-4);
        }];
    }
}



#pragma mark -

- (void)registerTableViewCell:(UITableView *)tableView {
    [tableView registerClass:[StarPopoverCell class] forCellReuseIdentifier:ContentCellReuseIdentifier];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ContentCellReuseIdentifier];
    [self tableView:tableView configureTableViewCell:cell indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView configureTableViewCell:(__kindof UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    if ([cell.reuseIdentifier isEqualToString:ContentCellReuseIdentifier]) {
        StarPopoverCell *contentCell = cell;
        contentCell.title = self.titles[indexPath.row];
        contentCell.titleColor = self.normalColor;
        contentCell.selectedTitleColor = self.selectedColor;
        if (self.currentSelectedIndex == indexPath.row) {
            contentCell.titleColor = self.selectedColor;
        }
        contentCell.separatorHidden = indexPath.row >= self.titles.count - 1;
        contentCell.separatorEdgeInset = UIEdgeInsetsMake(0, 15, 0, 5);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentSelectedIndex = indexPath.row;
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverViewController:didSelectRowAtIndex:)]) {
        [self.delegate popoverViewController:self didSelectRowAtIndex:self.currentSelectedIndex];
    }
}



#pragma mark - Setter

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self.tableView reloadData];
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    [self.tableView reloadData];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    [self.tableView reloadData];
}

- (void)setCurrentSelectedIndex:(NSInteger)currentSelectedIndex {
    _currentSelectedIndex = currentSelectedIndex;
    [self.tableView reloadData];
}

- (void)setCellHeight:(CGFloat)cellHeight {
    _cellHeight = cellHeight;
    [self.tableView reloadData];
}

@end






