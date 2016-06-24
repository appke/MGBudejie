//
//  MGEssenceViewController.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/9.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGEssenceViewController.h"
#import "MGRecommendTagsViewController.h"
#import "MGTopicViewController.h"

@interface MGEssenceViewController () <UIScrollViewDelegate>
/** 红色指示器 */
@property (nonatomic, weak) UIView *indicator;

/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;

/** 顶部所有标签栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的scrollView */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation MGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
    
    // 初始化子控制器
    [self setupChildVces];
    
    // 设置顶部标签
    [self setupTitlesView];
    
    // 设置底部的scrollView
    [self setupScrollview];
}

#pragma mark - 初始化子控制器
- (void)setupChildVces
{
    MGTopicViewController *word = [[MGTopicViewController alloc] init];
    word.title = @"段子";
    word.type = MGTopicTypeWord;
    [self addChildViewController:word];
    
    
    MGTopicViewController *video = [[MGTopicViewController alloc] init];
    video.title = @"视频";
    video.type = MGTopicTypeVideo;
    [self addChildViewController:video];
    
    MGTopicViewController *voice = [[MGTopicViewController alloc] init];
    voice.title = @"声音";
    voice.type = MGTopicTypeVoice;
    [self addChildViewController:voice];
    
    MGTopicViewController *picture = [[MGTopicViewController alloc] init];
    picture.title = @"图片";
    picture.type = MGTopicTypePicture;
    [self addChildViewController:picture];
    
    // 先创建5个子控制器，他们的view是用到时才加上去的
    MGTopicViewController *all = [[MGTopicViewController alloc] init];
    all.title = @"全部";
    all.type = MGTopicTypeAll;
    [self addChildViewController:all];
}

#pragma mark - 设置底部的scrollView
- (void)setupScrollview
{
    // 不要自动调整insert
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    self.contentView = contentView;
    
    // 添加第一个控制器
    [self scrollViewDidEndScrollingAnimation:contentView];
    
//    [contentView addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
//    
//    UISwitch *s = [[UISwitch alloc] init];
//    s.y = 780;
//    [contentView addSubview:s];
//    
//    contentView.contentSize = CGSizeMake(0, 800);
}

#pragma mark - 设置顶部标签
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
//    titlesView.backgroundColor = [UIColor whiteColor];
//    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
//    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    titlesView.width = self.view.width;
    titlesView.height = MGTitlesViewH;
    titlesView.y = MGTitlesViewY;
    self.titlesView = titlesView;
    [self.view addSubview:titlesView];

    // 底部红色指示器(放到上面先创建，否则刚开始不出现)???
    UIView *indicator = [[UIView alloc] init];
    indicator.tag = -1;
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = titlesView.height - indicator.height;
    self.indicator = indicator;
    
    // 内部子标签
//    NSArray *titles = @[@"全部全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat width = titlesView.width / self.childViewControllers.count;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.y = 0;
        button.width = width;
        button.height = titlesView.height;
        button.x = width * i;
        
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
//        [button layoutIfNeeded]; // 强制布局(更新子控件的frame)
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // 默认点击了第一个按钮
        if (i == 0) {
//            [self titleClicked:button];
            button.enabled = NO;
            self.selectedButton = button;
            
            // 添加这句指示器就出来了, 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicator.width = button.titleLabel.width;
            self.indicator.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicator];
}

- (void)titleClicked:(UIButton *)button
{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;

    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.width = button.titleLabel.width;
        self.indicator.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark - 设置导航栏
- (void)setupNav
{
    // 设置导航栏内容
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    self.view.backgroundColor = MGGlobalBg;
}

#pragma mark - 左上角标签item
- (void)tagClick
{
    MGRecommendTagsViewController *tags = [[MGRecommendTagsViewController alloc] init];
    [self.navigationController pushViewController:tags animated:YES];
}

#pragma mark - UIScrollView的代理
/**
 *  scrollView滚来滚去的动画完了之后
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 添加子控制器的view
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];
}

/**
 *  手一松开, 减速完毕
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 让按钮移动
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClicked:self.titlesView.subviews[index]];
}
@end
