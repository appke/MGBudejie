//
//  MGPushGuideView.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/18.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGPushGuideView.h"

@implementation MGPushGuideView

+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)close {
    
    [self removeFromSuperview];
}

+ (void)show
{
//    MGLog(@"%@", [NSBundle mainBundle].infoDictionary);
    NSString *key = @"CFBundleShortVersionString";
    // 获得当前软件版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号，上一次存储的
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    //
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        MGPushGuideView *guideView = [MGPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 存储当前版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
