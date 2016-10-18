//
//  ViewController.m
//  StarPopover
//
//  Created by 星星 on 16/10/18.
//  Copyright © 2016年 星星. All rights reserved.
//

#import "ViewController.h"
#import "StarPopover.h"
#import "StarPopoverViewController.h"

@interface ViewController () <StarPopoverViewControllerDelegate>
{}
@property (nonatomic, strong) StarPopover *popover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.popover = StarPopover.new;
    self.popover.cornerRadius = 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)handleBarButtonItemPop:(UIBarButtonItem *)sender {
    
    UIView *view = UIView.new;
    view.frame = CGRectMake(0, 0, 100, 100);
    
    
    NSArray *titles = @[@"添加好友", @"扫一扫", @"系统设置"];
    
    StarPopoverViewController *controller = [[StarPopoverViewController alloc] initWithTitles:titles];
    controller.selectedColor = [UIColor orangeColor];
    controller.normalColor = [UIColor darkGrayColor];
    controller.currentSelectedIndex = -1;
    controller.preferredContentSize = CGSizeMake(100, 40 * titles.count);
    controller.delegate = self;
    self.popover.betweenAtViewAndArrowHeight = 30;
    [self.popover showAtBarButtonItem:sender withContentViewController:controller];
}

- (IBAction)handleRightPop:(UIButton *)sender {
    CGPoint showPoint = [sender convertPoint:CGPointMake(sender.frame.size.width, sender.frame.size.height / 2) toView:self.view];
    [self popoverWithSender:sender point:showPoint position:(StarPopoverPositionRight)];
}
- (IBAction)handleLeftPop:(UIButton *)sender {
    CGPoint showPoint = [sender convertPoint:CGPointMake(0, sender.frame.size.height / 2) toView:self.view];
    [self popoverWithSender:sender point:showPoint position:(StarPopoverPositionLeft)];
}
- (IBAction)handleUpPop:(UIButton *)sender {
    CGPoint showPoint = [sender convertPoint:CGPointMake(sender.frame.size.width / 2, 0) toView:self.view];
    [self popoverWithSender:sender point:showPoint position:(StarPopoverPositionUp)];
}
- (IBAction)handleDownPop:(UIButton *)sender {
    CGPoint showPoint = [sender convertPoint:CGPointMake(sender.frame.size.width / 2, sender.frame.size.height) toView:self.view];
    [self popoverWithSender:sender point:showPoint position:(StarPopoverPositionDown)];
}


- (void)popoverWithSender:(UIView *)sender point:(CGPoint)point position:(StarPopoverPosition)position {
    
    NSArray *titles = @[@"添加好友", @"扫一扫", @"系统设置"];
    
    StarPopoverViewController *controller = [[StarPopoverViewController alloc] initWithTitles:titles];
    controller.selectedColor = [UIColor orangeColor];
    controller.normalColor = [UIColor darkGrayColor];
    controller.currentSelectedIndex = -1;
    controller.preferredContentSize = CGSizeMake(100, 40 * titles.count);
    controller.delegate = self;
    
    [self.popover showAtPoint:point
               popoverPostion:position
    withContentViewController:controller
                       inView:[UIApplication sharedApplication].keyWindow];
}


- (void)popoverViewController:(StarPopoverViewController *)viewController didSelectRowAtIndex:(NSInteger)index {
    [self.popover dismiss];
}

@end
