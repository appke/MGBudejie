//
//  MGComment.h
//  百思不得姐
//
//  Created by 穆良 on 16/4/4.
//  Copyright © 2016年 穆良. All rights reserved.
//评论模型

#import <Foundation/Foundation.h>
@class MGUser;
@interface MGComment : NSObject
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 被点赞的数量 */
@property (nonatomic, assign) NSInteger like_count;
/** 用户 */
@property (nonatomic, strong) MGUser *user;

@end
