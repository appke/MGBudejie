//
//  MGShowPictureViewController.h
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/25.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGTopic;
@interface MGShowPictureViewController : UIViewController

/** 帖子，要知道图片宽高 */
@property (nonatomic, strong) MGTopic *topic;
@end
