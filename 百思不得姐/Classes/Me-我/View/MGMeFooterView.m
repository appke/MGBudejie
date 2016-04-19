//
//  MGMeFooterView.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/12.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGMeFooterView.h"
#import <AFNetworking.h>
#import <MJExtension.h>

#import "MGSquare.h"
#import "MGSquareButton.h"
#import "MGMeWebViewController.h"


@implementation MGMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        self.backgroundColor = [UIColor clearColor];
        [self loadData];
    }

    return self;
}

#pragma mark - 加载数据
- (void)loadData {
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [responseObject[@"square_list"] writeToFile:@"/Users/MG/Desktop/square.plist" atomically:YES];
        
        NSArray *squares = [MGSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        // 到这一步squares里面肯定有值
        [self createSquares:squares];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 创建九宫格
- (void)createSquares:(NSArray *)squares
{
    // 一行最多显示4列
    NSInteger maxCols = 4;
    CGFloat buttonW = self.width / maxCols;
    CGFloat buttonH = buttonW;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    
    for (int i = 0; i < squares.count; i++) {
        
//        MGSquare *square = squares[i];
        MGSquareButton *button = [[MGSquareButton alloc] init];
        button.square = squares[i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        NSInteger col = i % maxCols;
        NSInteger row = i / maxCols;
        
        buttonX = col * buttonW;
        buttonY = row * buttonH;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 设置footer的高度
//        self.height = CGRectGetMaxY(button.frame);
    }
    
//    NSUInteger rows = self.subviews.count / maxCols;
//    if (self.subviews.count % maxCols) { // 不能整除, +1
//        rows++;
//    }
    
    
    // 设置footer的高度
    self.height = (self.subviews.count+ maxCols - 1)/maxCols * buttonH;
    // 重绘
    [self setNeedsDisplay];
}

#pragma mark - 设置背景图片
//- (void)drawRect:(CGRect)rect
//{
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}


#pragma mark - 按钮点击
- (void)buttonClick:(MGSquareButton *)button
{
    if (![button.square.url hasPrefix:@"http"]) return;
    
    MGMeWebViewController *web = [[MGMeWebViewController alloc] init];
    web.url = button.square.url;
    web.title = button.square.name;
    
    UITabBarController *tabbarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)[tabbarVc selectedViewController];
    
//    MGLog(@"%@\n%@", tabbarVc, nav);
    
    [nav pushViewController:web animated:YES];
}

@end
