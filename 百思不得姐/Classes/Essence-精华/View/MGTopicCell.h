//
//  MGTopicViewCell.h
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/20.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MGTopic;
@interface MGTopicCell : UITableViewCell

/** 帖子数据 */
@property (nonatomic, strong) MGTopic *topic;
@end
