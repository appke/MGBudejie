//
//  MGRecommendUser.h
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/10.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGRecommendUser : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 粉丝数(有多少人关注) */
@property (nonatomic, assign) NSInteger fans_count;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;


@end
/**
 *
@property (nonatomic, assign) NSInteger tiezi_count;
{
	introduction = ,
	uid = 15854741,
	header = http://wimg.spriteapp.cn/profile/large/2015/09/15/55f78a7a9e433_mini.jpg,
	gender = 1,
	is_vip = 0,
	fans_count = 87411,
	tiezi_count = 182,
	is_follow = 0,
	screen_name = 大力金刚-夯大力
 },
 */