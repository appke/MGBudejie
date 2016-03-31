//
//  MGTopicViewController.h
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/20.
//  Copyright © 2016年 穆良. All rights reserved.
// 最基本的帖子控制器

#import <UIKit/UIKit.h>



@interface MGTopicViewController : UITableViewController
/** 帖子类型(交给子类实现) */
@property (nonatomic, assign) MGTopicType type;

@end
