//
//  MGRecommendTagsViewController.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/11.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGRecommendTagsViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "MGRecommendTag.h"
#import "MGRecommendTagCell.h"

@interface MGRecommendTagsViewController ()
/** 标签数据 */
@property (nonatomic, strong) NSArray *tags;
@end

static NSString * const tagID = @"tag";

@implementation MGRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐标签";
    
    // 控件初始化
    [self setupTableView];
    
    // 加载推荐标签数据
    [self loadRecommendTags];

}
#pragma mark - 初始化表格
- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MGRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:tagID];
    // 设置row的高度
    self.tableView.rowHeight = 70;
    // 不要分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 控制器的view就是tableView,设置为全局色
    self.tableView.backgroundColor = MGGlobalBg;
}


#pragma mark - 发送请求
- (void)loadRecommendTags
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    // 请求参数
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"a"] = @"tag_recommend";
    paras[@"action"] = @"sub";
    paras[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:paras success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 结束提示
        [SVProgressHUD dismiss];
        
        self.tags = [MGRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        //        MGLog(@"%@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载推荐标签数据失败"];
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MGRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagID forIndexPath:indexPath];
    cell.recommendTag = self.tags[indexPath.row];
    
    return cell;
}



@end
