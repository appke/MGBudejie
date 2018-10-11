//
//  MGTabBarController.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/8.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTabBarController.h"
#import "MGEssenceViewController.h"
#import "MGFriendTrendsViewController.h"
#import "MGMeViewController.h"
#import "MGNewViewController.h"
#import "MGTabBar.h"

#import "MGNavigationController.h"

@interface MGTabBarController ()

@end

@implementation MGTabBarController

+ (void)initialize {
    // 设置颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];

    // 设置字体
    NSMutableDictionary *selAttrs = [NSMutableDictionary dictionary];
    selAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];

    //    UITabBarItem *tabBarItem = [UITabBarItem appearance]; // 有坑
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    [tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //    UIViewController *vc01 = [[UIViewController alloc] init];
    //    vc01.tabBarItem.title = @"精华";
    //    vc01.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    //    UIImage *selImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    //    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    vc01.tabBarItem.selectedImage = selImage;

    [self setupChildVc:[[MGEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];

    [self setupChildVc:[[MGNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];

    [self setupChildVc:[[MGFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];

    [self setupChildVc:[[MGMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];

    // 更换tabBar
    //    self.tabBar = [[MGTabBar alloc] init];
    [self setValue:[[MGTabBar alloc] init] forKey:@"tabBar"];
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //    vc.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1.0];
    MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:vc];

    [self addChildViewController:nav];
}

@end
