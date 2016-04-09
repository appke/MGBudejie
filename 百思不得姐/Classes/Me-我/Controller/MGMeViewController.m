//
//  MGMeViewController.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/9.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGMeViewController.h"

@interface MGMeViewController ()

@end

@implementation MGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    self.view.backgroundColor = MGGlobalBg;
    
//    MGLogFunc;
    
//    self.tableView.separatorStyle
//    self.tableView.visibleCells[0].selectionStyle
    
}

- (void)settingClick
{
    MGLogFunc;
}

- (void)moonClick
{
    MGLogFunc;
}


@end
