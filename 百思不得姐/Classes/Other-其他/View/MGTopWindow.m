//
//  MGTopWindow.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/10.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTopWindow.h"

@implementation MGTopWindow

static UIWindow *window_;

+ (void)initialize
{
    // 创建window
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, MGScreenW, 20);
//    window_.backgroundColor = [UIColor redColor];
    
    // 一定要是alert级别的, 否则点击没反应显示在状态栏的后面, 被遮住了
    window_.windowLevel = UIWindowLevelAlert;
    
    // 添加手势, 类方法里面, self是类, 调用的也是类方法, 否则找不到
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
    
    
}

/**
 *  监听窗口的点击,回到最顶部
 */
+ (void)windowClick
{
    // 找到显示在眼前的控制器
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    [self searchScrollViewInView:keyWindow];
}

+ (void)searchScrollViewInView:(UIView *)superView
{
    for (UIScrollView *subView in superView.subviews) {
        
        // 转换坐标系，返回一个新的frame
//        CGRect newFrame = [subView.superview convertRect:subView.frame toView:[UIApplication sharedApplication].keyWindow];
        // nil是以屏幕左上角, 为坐标原点
//        CGRect newFrame = [subView.superview convertRect:subView.frame toView:nil];
        
        // 从原来的从原来的坐标系, 转成UIWindow的
        // 得到subView在窗口中的frame
        CGRect newFrame = [[UIApplication sharedApplication].keyWindow convertRect:subView.frame fromView:subView.superview];
        CGRect winBounds = [UIApplication sharedApplication].keyWindow.frame;
        // 两个矩形框有没有交叉
        
        BOOL isShowingOnWindow = (subView.window == [UIApplication sharedApplication].keyWindow) && !subView.hidden && subView.alpha > 0.01 && CGRectIntersectsRect(winBounds, newFrame);
        
        //CGRectIntersectsRect([UIApplication sharedApplication].keyWindow.frame, );
        
        // 如果是scrollView, 滚动到最顶部
        if ([subView isKindOfClass:[UIScrollView class]] && [subView isShowingInKeyWindow]) {
            CGPoint offset = subView.contentOffset;
            offset.y = -subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件 - 递归
        [self searchScrollViewInView:subView];
    }
}

+ (void)show
{
    window_.hidden = NO;
}

+ (void)hide
{
    window_.hidden = YES;
}

@end
