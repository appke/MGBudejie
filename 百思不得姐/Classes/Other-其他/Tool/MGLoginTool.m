//
//  MGLoginTool.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/21.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGLoginTool.h"
#import "MGLoginRegisterViewController.h"

@implementation MGLoginTool

+ (void)setUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getUid
{
    return [self getUid:NO];
}

+(NSString *)getUid:(BOOL)isShowViewController
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] valueForKey:@"uid"];
    
    if (isShowViewController) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            MGLoginRegisterViewController *loginVc = [[MGLoginRegisterViewController alloc] init];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginVc animated:YES completion:nil];
        });
    }
    
    return uid;
}
@end
