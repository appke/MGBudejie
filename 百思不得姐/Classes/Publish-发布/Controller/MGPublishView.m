//
//  MGPublishView.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/25.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGPublishView.h"
#import "MGVerticalButton.h"
#import <pop/POP.h>
#import "MGPostWordViewController.h"
#import "MGNavigationController.h"
#import "MGLoginTool.h"

#define MGRootView [UIApplication sharedApplication].keyWindow.rootViewController.view

@interface MGPublishView ()
@end


static CGFloat const MGAnimationDelay = 0.12;
static CGFloat const MGAnimationSpeed = 10;

@implementation MGPublishView

/** 类方法 快速返回一个view */
+ (instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

// 不用全局变量, 窗口一创建就销毁了
static UIWindow *window_;
+ (void)show
{
    window_ = [[UIWindow alloc] init];
    window_.frame = [UIScreen mainScreen].bounds;
    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.95];
    window_.hidden = NO;
    
    MGPublishView *publish = [MGPublishView publishView];
    publish.frame = window_.bounds;
    [window_ addSubview:publish];
}

- (void)awakeFromNib
{
    // 让控制器view不能点击
    self.userInteractionEnabled = NO;
//    MGRootView.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间6个按钮
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStarY = (MGScreenH - 2*buttonH) * 0.5;
    CGFloat buttonStatX = 15;
    int maxCol = 3;
    CGFloat xMargin = (MGScreenW - 2*buttonStatX - maxCol * buttonW) / (maxCol -1);
    
    for (int i = 0; i< images.count; i++) {
        
        MGVerticalButton *button = [[MGVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        // 设置内容
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        // 计算x\y
        int row = i / maxCol;
        int col = i % maxCol;
        CGFloat buttonX = buttonStatX + (buttonW + xMargin) * col;
        CGFloat buttonEndY = buttonStarY + buttonH * row;
        CGFloat buttonBeginY = buttonEndY - MGScreenH;
        
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springSpeed = 10;
        anim.springBounciness = 10;
        anim.beginTime = CACurrentMediaTime() + MGAnimationDelay * i;
        
        [button pop_addAnimation:anim forKey:nil];
    }
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    
    // 标语动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = MGScreenW * 0.5;
    CGFloat centerEndY = MGScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - MGScreenH;
    sloganView.centerY = centerBeginY;
    sloganView.centerX = centerX;
    
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * MGAnimationDelay;
    anim.springSpeed = MGAnimationSpeed;
    anim.springBounciness = MGAnimationSpeed;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 标语动画完成, 恢复点击事件
        self.userInteractionEnabled = YES;
//        MGRootView.userInteractionEnabled = YES;
    }];
    
    [sloganView pop_addAnimation:anim forKey:nil];
}

#pragma mark - 按钮点击 退出 弹出新的控制器
- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        
//        if (button.tag == 0) {
//            MGLog(@"发视频");
//        } else if (button.tag == 1) {
//            MGLog(@"发图片");
//        }
        if (button.tag == 2) {
            
            // 判断是否登录
//            if([MGLoginTool getUid:YES] == nil) return;
            
            MGPostWordViewController *postWord = [[MGPostWordViewController alloc] init];
            MGNavigationController *nav = [[MGNavigationController alloc] initWithRootViewController:postWord];
            
            UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
            [root presentViewController:nav animated:YES completion:nil];
        }
    }];
}

#pragma mark - 取消
- (IBAction)cancel {
    
    [self cancelWithCompletionBlock:nil];
}

/**
 *  先执行退出动画，再执行动画完毕后的操作
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    // 让控制器view不能点击
    self.userInteractionEnabled = NO;
//    MGRootView.userInteractionEnabled = NO;
    
    int beginIndex = 1;
    for (int i = beginIndex; i< self.subviews.count; i++) {
        
        UIView *subView = self.subviews[i];
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerEndY = subView.centerY + MGScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerEndY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * MGAnimationDelay;
        // 执行时间
        anim.duration = 0.2;
        // 动画执行节奏(开始很慢,后来很快)
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [subView pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.subviews.count - 1) {
            
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {

//                MGRootView.userInteractionEnabled = YES;
//                [self removeFromSuperview];
                // 销毁窗口
                window_.hidden = YES;
                window_ = nil;
                // 执行传递过来的block
                //            if (completionBlock) {
                //                completionBlock();
                //            }

                // 装逼写法
                !completionBlock ? :completionBlock();
            }];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancelWithCompletionBlock:nil];
}
@end