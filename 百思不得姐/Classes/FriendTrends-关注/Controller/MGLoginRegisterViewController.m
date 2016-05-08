//
//  MGLoginRegisterViewController.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/16.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGLoginRegisterViewController.h"
#import "MGTopWindow.h"

@interface MGLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

/** 登录框 距离 控制器view 左边的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@end

@implementation MGLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view insertSubview:self.bgView atIndex:0];
//
//    self.loginButton.layer.cornerRadius = 5;
//    self.loginButton.layer.masksToBounds = YES;
    
//    NSMutableAttributedString

}

- (IBAction)showLoginOrRegister:(UIButton *)button {
    
    // 切换的退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { // 最开始的情况
        // 显示注册
        self.loginViewLeftMargin.constant = -self.view.width;
//        [button setTitle:@"已有账号?" forState:UIControlStateNormal];
        button.selected = YES;
        
    } else { // 显示登录
        self.loginViewLeftMargin.constant = 0;
//        [button setTitle:@"注册账号" forState:UIControlStateNormal];
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        // 马上更新布局
        [self.view layoutIfNeeded];
    }]; 
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [MGTopWindow show];
}

/**
 *  不要一下子就变白
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [MGTopWindow hide];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    // 亮色，就是白色
    return UIStatusBarStyleLightContent;
}

@end
