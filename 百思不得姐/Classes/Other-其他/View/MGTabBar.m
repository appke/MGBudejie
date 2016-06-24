//
//  MGTabBar.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/9.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTabBar.h"
#import "MGPublishView.h"

//--------
#import "MGNavigationController.h"
#import "MGPostWordViewController.h"

@interface MGTabBar()
/** 发布按钮 */
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation MGTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置tabBar的背景色
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        UIButton *publishButton = [[UIButton alloc] init];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
    }
    return self;
}

#pragma mark - 发布按钮
- (void)publishClick
{
//    MGPublishView *publish = [MGPublishView publishView];
//    UIWindow * window = [UIApplication sharedApplication].keyWindow;
//    publish.frame = window.bounds;
//    
////    [window addSubview:publish];
//    [window.rootViewController.view addSubview:publish];
    
//    window1 = [[UIWindow alloc] init];
//    window1.frame = [UIScreen mainScreen].bounds;
//    window1.hidden = NO;
//    
//    window1.windowLevel
    
//    MGPostWordViewController *postWord = [[MGPostWordViewController alloc] init];
//    MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:postWord];
//    
//    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
//    [root presentViewController:nav animated:YES completion:nil];
    
    [MGPublishView show];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 标记按钮是否已经添加过监听器,这个方法会重复调用
    static BOOL added = NO;
    
    // 设置发布按钮的frame
//    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
//    self.publishButton.height =self.publishButton.currentBackgroundImage.size.height;
//    self.publishButton.size = self.publishButton.currentBackgroundImage.size
    self.publishButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    // 设置其他UITabBarButton 的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 5;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
    
    for (UIControl *button in self.subviews) {
        
        // 只有四个按钮, 发布按钮不算
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) continue;

        // 计算按钮的x值
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
        
        if (added == NO) {
            // 监听按钮点击
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    added = YES;
}

- (void)buttonClick
{
    // 发一个通知
    [MGNoticeCenter postNotificationName:MGTabBarDidSelectNotification object:nil userInfo:nil];
}

@end
