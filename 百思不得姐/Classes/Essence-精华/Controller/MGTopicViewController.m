//
//  MGTopicViewController.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/18.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import "MJRefresh.h"
#import "MGTopic.h"
#import "MGTopicCell.h"
#import "MGCommentViewController.h"
#import "MGNewViewController.h"

@interface MGTopicViewController ()
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;

/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据时,需要这个参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;

/** 上一次选中的索引 */
@property (nonatomic, assign) NSInteger lastSelectedIndex;

@end

static NSString * const topicID = @"topic";
@implementation MGTopicViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
}

#pragma mark - 初始化表格
- (void)setupTableView
{
    // 设置内编剧，不让里面的内容被挡住
    CGFloat top = MGTitlesViewY + MGTitlesViewH;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // 表格分割线样式
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置滚动条的内编剧
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MGTopicCell class]) bundle:nil] forCellReuseIdentifier:topicID];
    
    // 监听tabbar点击的通知
    [MGNoticeCenter addObserver:self selector:@selector(tabBarSelect) name:MGTabBarDidSelectNotification object:nil];
}

- (void)tabBarSelect
{
    // 如果是连续点2次, 控制器的view在窗口上
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.isShowingInKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
    }
    
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}


#pragma mark - 集成刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 一进来就刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    // 一开始要隐藏，不要出现
    //    self.tableView.mj_footer.hidden = YES;
    
}

#pragma mark - 返回不同参数
- (NSString *)a {
    // topic控制器，都是当前控制的的儿子
    return [self.parentViewController isKindOfClass:[MGNewViewController class]] ? @"newlist" : @"list";
}


#pragma mark - 数据处理
/**
 *  加载新的帖子数据
 */
- (void)loadNewTopics
{
    // 结束mj_footer刷新
    [self.tableView.mj_footer endRefreshing];
    self.page = 0;
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (self.params != params) return;
        
        // 字典 -> 模型
        self.topics = [MGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 存储maxtime 加载下一页需要
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
//        [responseObject[@"list"] writeToFile:@"/Users/MG/Desktop/tiezi.plist" atomically:YES];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.params != params) return;
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 *  加载更多帖子数据
 */
- (void)loadMoreTopics
{
    // 结束mj_header刷新
    [self.tableView.mj_header endRefreshing];
    // 页码
    self.page++;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.params != params) return;
        
        NSArray *newTopics = [MGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:newTopics];
        
        // 存储maxtime 加载下一页需要
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 刷新表格
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicID];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGCommentViewController *commentVc = [[MGCommentViewController alloc] init];
    commentVc.topic = self.topics[indexPath.row];
    
    [self.navigationController pushViewController:commentVc animated:YES];
}

#pragma mark - 表格代理方法 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 返回这个模型对应的cell高度
    MGTopic *topic = self.topics[indexPath.row];
    return topic.cellHeight;
}

@end
