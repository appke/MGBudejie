//
//  MGCommentViewController.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/9.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGCommentViewController.h"
#import "UIBarButtonItem+MGExtension.h"
#import "MGTopicCell.h"
#import "MGTopic.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MGComment.h"
#import "MGCommentHeaderView.h"
#import "MGCommentCell.h"


@interface MGCommentViewController () <UITableViewDelegate, UITableViewDataSource>
/** 底部工具条和view的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
/** 评论列表 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论-固定 */
@property (nonatomic, strong) NSArray *hotComments;
/** 最新评论-上拉可加载更多 */
@property (nonatomic, strong) NSMutableArray *latesComments;
/** 保存cell中最热评论-模型 */
@property (nonatomic, strong) MGComment *saved_top_cmt;
@end


static NSString *const commentId = @"comment";

@implementation MGCommentViewController

//- (NSArray *)hotComments
//{
//    if (!_hotComments) {
//        _hotComments = [NSArray array];
//    }
//    return _hotComments;
//}
//
//- (NSMutableArray *)latesComments
//{
//    if (!_latesComments) {
//        _latesComments = [NSMutableArray array];
//    }
//    return _latesComments;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    [self setupBase];
    
    // 初始化表格头部
    [self setupHeader];
    
    // 添加刷新控件
    [self setupRefresh];
}

/**
 *  继承刷新控件
 */
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
    [self.tableView.mj_header beginRefreshing];
//    self.tableView.mj_footer.hidden = YES;
}

#pragma mark - 数据加载
- (void)loadNewComments
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] =  @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1; // 最热评论
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [responseObject writeToFile:@"/Users/MG/Desktop/comments.plist" atomically:YES];
        self.hotComments = [MGComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        self.latesComments = [MGComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        
        // 刷新表格
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 *  加载更多数据
 */
- (void)loadMoreComments
{
    MGLogFunc;
}

#pragma mark - 初始化
- (void)setupHeader
{
    // 清空top_cmt数组
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    // 设置header
    UIView *header = [[UIView alloc] init];
    // 直接返回一个topicCell
    MGTopicCell *cell = [MGTopicCell cell];
    
    cell.topic = _topic;
//    cell.height = self.topic.cellHeight;
    cell.size = CGSizeMake(MGScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    // header的高度
    header.height = self.topic.cellHeight+ MGTopicCellMargin;
//    header.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = header;
}

- (void)setupBase
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:nil];
    
    // 监听键盘弹出,包括显示和隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 背景色
    self.tableView.backgroundColor = MGGlobalBg;
    
    // 注册表格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MGCommentCell class]) bundle:nil] forCellReuseIdentifier:commentId];
    
    // cell高度自动计算
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

/**
 *  监听键盘显示和隐藏
 */
- (void)KeyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘显示、隐藏完毕的frame，最终的尺寸
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 改变底部工具条的高度
    self.bottomSpace.constant = MGScreenH - frame.origin.y;
    
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画
    [UIView animateWithDuration:duration animations:^{
        // 强制布局
        [self.view layoutIfNeeded];
    }];
}

/**
 *  拖拽隐藏键盘
 *  稍微动一下, 就调用，scrollView太频繁了
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - 销毁控制器
- (void)dealloc
{
    // 恢复帖子的top_cmt
    if (self.saved_top_cmt) {
        
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 表格数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 可能没有最热评论
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latesComments.count;
    
    if (hotCount) return 2; // 最热评论 + 最新评论
    if (latestCount) return 1;
    
    return 10 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latesComments.count;
    
    if (section == 0) { // 最热评论有没有，没有第0组就是最新评论
        return hotCount ? hotCount : latestCount;
    }
    
    // 非第0组
    return latestCount;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComments.count;
////    NSInteger latestCount = self.latesComments.count;
//    
//    if (section == 0) { // 最热评论有没有，没有第0组就是最新评论
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    // 非第0组
//    return @"最新评论";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 先从缓存池中找header
    MGCommentHeaderView *header = [MGCommentHeaderView headerViewWithTableView:tableView];
    
    // 设置label数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) { // 最热评论有没有，没有第0组就是最新评论
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else { // 非第0组
        header.title = @"最新评论";
    }
    
    return header;
    
    
//    // 创建头部
//    UIView *header = [[UIView alloc] init];
//    header.backgroundColor = MGGlobalBg;
//    
//    // 创建label
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = MGRGBColor(67, 67, 67);
//    label.font = [UIFont systemFontOfSize:14];
//    label.width = 200;
//    label.x = MGTopicCellMargin;
//    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    
////    label.backgroundColor = [UIColor redColor];
//    [header addSubview:label];
//    
//    NSInteger hotCount = self.hotComments.count;
//    if (section == 0) { // 最热评论有没有，没有第0组就是最新评论
//        label.text = hotCount ? @"最热评论" : @"最新评论";
//    } else { // 非第0组
//        label.text = @"最新评论";
//    }
//    
//    return header;
}

/**
 *  返回第section组所有数据
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count? self.hotComments: self.latesComments;
    }
    // 非第0组
    return self.latesComments;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    MGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentId];
    
    // 2.设置cell的数据
    MGComment *comment  = [self commentsInSection:indexPath.section][indexPath.row];
    cell.comment = comment;
    
    // 3.返回cell
    return cell;
}
@end