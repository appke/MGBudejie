//
//  MGPostWordViewController.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/14.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGPostWordViewController.h"

@interface MGPostWordViewController ()

@end

@implementation MGPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.title = @"发段子";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(post)];
    
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    MGLogFunc;
}

@end
