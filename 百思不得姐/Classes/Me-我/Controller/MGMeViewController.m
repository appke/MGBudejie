//
//  MGMeViewController.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/9.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGMeViewController.h"
#import "MGMeCell.h"
#import "MGMeFooterView.h"

@interface MGMeViewController ()

@end


@implementation MGMeViewController
static NSString *const MGMeCellId = @"me";
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    
    [self setupTableView];
}

#pragma mark - 设置导航栏
- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.title = @"我的";
    
    // 设置导航栏右边的按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

#pragma mark - 初始化表格
- (void)setupTableView
{
    // 设置背景色
    self.view.backgroundColor = MGGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 注册cell
    [self.tableView registerClass:[MGMeCell class] forCellReuseIdentifier:MGMeCellId];
    
    // 调整header和footer的高度
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = MGTopicCellMargin;
    
    // 表格往上挪
    self.tableView.contentInset = UIEdgeInsetsMake(MGTopicCellMargin-35, 0, 0, 0);
    
//    UIButton *add = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    add.backgroundColor = [UIColor orangeColor];
//    self.tableView.tableHeaderView = add;
//    
//    UIButton *add2 = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    add2.backgroundColor = [UIColor redColor];
//    self.tableView.tableFooterView = add2;
    self.tableView.tableFooterView = [[MGMeFooterView alloc] init];
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGMeCell *cell = [tableView dequeueReusableCellWithIdentifier:MGMeCellId];
//    MGMeCell *cell = [tableView dequeueReusableCellWithIdentifier:MGMeCellId forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }

    return cell;
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
