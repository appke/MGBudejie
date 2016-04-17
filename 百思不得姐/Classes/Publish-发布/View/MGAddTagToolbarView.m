//
//  MGAddTagToolbarView.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/16.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGAddTagToolbarView.h"
#import "MGAddTagViewController.h"

@interface MGAddTagToolbarView ()
/** 顶部view */
@property (weak, nonatomic) IBOutlet UIView *topView;


@end

@implementation MGAddTagToolbarView

- (void)awakeFromNib
{
    // 添加一个按钮
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
//    addButton.size = [UIImage imageNamed:@"tag_add_icon"].size;
//    addButton.size = [addButton imageForState:UIControlStateNormal].size;
    addButton.size = addButton.currentImage.size;
    addButton.x = MGTopicCellMargin;
    
    [self.topView addSubview:addButton];
}

- (void)buttonClick
{
    MGAddTagViewController *addTagVc = [[MGAddTagViewController alloc] init];

    UITabBarController *root = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    UINavigationController *nav = (UINavigationController *)[root selectedViewController];
//    UIViewController *topVc = nav.topViewController;
    UINavigationController *postNav = (UINavigationController *)root.presentedViewController;
    
    [postNav pushViewController:addTagVc animated:YES];
    
//    MGLog(@"%@\n%@\n%@", root, nav, topVc);
}

@end
