//
//  MGFriendTrendsViewController.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/9.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGFriendTrendsViewController.h"
#import "MGRecommendViewController.h"
#import "MGLoginRegisterViewController.h"

@interface MGFriendTrendsViewController ()

@end

@implementation MGFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
   
    self.view.backgroundColor = MGGlobalBg;
    
//    MGLogFunc;
    
}

// 点击关注
- (void)friendsClick
{
//    MGLogFunc;
    MGRecommendViewController *vc = [[MGRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginRegister {
    
    MGLoginRegisterViewController *log = [[MGLoginRegisterViewController alloc] init];
    [self presentViewController:log animated:YES completion:nil];
}


@end
