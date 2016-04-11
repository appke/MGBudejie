//
//  MGRecommendViewController.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/9.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "MGRecommendCategoryCell.h"
#import "MGRecommendCategory.h"
#import "MGRecommendUserCell.h"
#import "MGRecommendUser.h"
#import "MJRefresh.h"

// 选中的类别
#define MGSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface MGRecommendViewController () <UITableViewDelegate, UITableViewDataSource>
/** 左侧类别数据 */
@property (nonatomic, strong) NSArray *categories;
/** 左侧类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右侧用户数据 */
@property (nonatomic, strong) NSArray *users;
/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *paras;
/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation MGRecommendViewController

static NSString * const categoryID = @"category";
static NSString *const userID = @"user";


- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setupTableView];
    
    // 集成刷新控件
    [self setupRefresh];
    
    // 加载左侧类别数据
    [self loadCategories];
}

#pragma mark - 加载左侧类别数据
- (void)loadCategories
{
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack]; // 有遮盖
    // 发送请求
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"] = @"category";
    paras[@"c"] = @"subscribe";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:paras success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 隐藏显示器
        [SVProgressHUD dismiss];
        
        self.categories = [MGRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [self.categoryTableView reloadData];
        // 默认选中首行, 从最顶部显示出来
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

#pragma mark - 表格的初始化
- (void)setupTableView
{
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MGRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MGRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    // 标题
    self.navigationItem.title = @"推荐关注";
    // 设置背景颜色
    self.view.backgroundColor = MGGlobalBg;
    self.categoryTableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - 集成刷新控件
- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUser)];
    
    // 表格的mj_footer, 没有数据时也会显示，要设置显示和隐藏
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

#pragma mark - 加载更多用户数据
- (void)loadMoreUsers
{
    MGRecommendCategory *category = MGSelectedCategory;
    // 发送请求，加载右边数据
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"] = @"list";
    paras[@"c"] = @"subscribe";
    paras[@"category_id"] = @(category.id);
    paras[@"page"] = @(++category.currentPage);
    self.paras = paras;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:paras success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 字典数组——>模型数组
        NSArray *users = [MGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 添加到当前类别对应的数组中
        [category.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.paras != paras) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        [self checkFooterSate];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.paras != paras) return;
        // 提示
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        // 结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 加载最新的用户数据
- (void)loadNewUser
{
    MGRecommendCategory *category = MGSelectedCategory;
    // 加载第一页数据,设置当前页码为1,尽管不需要数据
    category.currentPage = 1;
    
    // 发送请求，加载右边数据
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"] = @"list";
    paras[@"c"] = @"subscribe";
    paras[@"category_id"] = @(category.id);
    paras[@"page"] = @(category.currentPage);
    self.paras = paras;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:paras success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        // 字典数组——>模型数组
        NSArray *users = [MGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 先清除所有旧数据
        [category.users removeAllObjects];
        // 添加到当前类别的数组中
        [category.users addObjectsFromArray:users];
        // 保存总数
        category.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.paras != paras) return;
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        // footer的状态
        [self checkFooterSate];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.paras != paras) return;
        // 提示
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
    
}

/**
 *  时刻监测footer的状态
 */
- (void)checkFooterSate
{
    MGRecommendCategory *category = MGSelectedCategory;
    // 每次刷新右边数据时，都控制footer显示或隐藏
    self.userTableView.mj_footer.hidden = (category.users.count == 0);
    
    // 让底部控件结束刷新
    if (category.total == category.users.count) { // 全部都加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        // 让底部控件结束刷新,等待下一次刷新
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark - 表格的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 左边类别表格
    if (tableView == self.categoryTableView) return self.categories.count;
    
    // 检测footer的状态
    [self checkFooterSate];
    // 右边用户表格
    return [MGSelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { // 左边类别表格
        // 1.创建cell
        MGRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        // 2.设置cell的数据
        cell.category = self.categories[indexPath.row];
        return cell;
        
    } else { // 右边用户表格
        MGRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        MGRecommendCategory *category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = category.users[indexPath.row];
        return cell;
    }
}

#pragma mark - 表格的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        [self.userTableView.mj_footer endRefreshing];
        
        MGRecommendCategory *category = self.categories[indexPath.row];
        if (category.users.count) {
            // 显示曾经的数据
            [self.userTableView reloadData];
        } else {
            // 赶紧刷新表格—>显示当前category的用户数据,不让用户看见上一个category残留数据
            [self.userTableView reloadData];
            // 进入下拉刷新状态
            [self.userTableView.mj_header beginRefreshing];
        }
    } else {
        
    }
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    // 停止所有请求操作
    [self.manager.operationQueue cancelAllOperations];
}

@end
