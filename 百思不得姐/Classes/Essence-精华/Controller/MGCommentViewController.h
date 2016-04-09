//
//  MGCommentViewController.h
//  百思不得姐
//
//  Created by 穆良 on 16/4/9.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGTopic;

@interface MGCommentViewController : UIViewController

/** 帖子数据 */
@property (nonatomic, strong) MGTopic *topic;

@end
