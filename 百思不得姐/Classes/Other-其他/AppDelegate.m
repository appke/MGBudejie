//
//  AppDelegate.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/8.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "AppDelegate.h"
#import "MGTabBarController.h"
#import "MGPushGuideView.h"
#import "MGTopWindow.h"


@interface AppDelegate () <UITabBarControllerDelegate>
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor redColor];
    
    // 设置窗口的根控制器
    MGTabBarController *tabBarController = [[MGTabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    
    tabBarController.delegate = self;
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    // 显示推送引导
    [MGPushGuideView show];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // 添加一个window,屏幕上的scrollView滚动到最顶部
    [MGTopWindow show];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - tabBarController的代理方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // 发出一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:MGTabBarDidSelectNotification object:nil userInfo:nil];
}

@end
