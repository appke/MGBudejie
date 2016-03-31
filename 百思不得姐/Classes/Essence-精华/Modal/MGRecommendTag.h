//
//  MGRecommendTag.h
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/11.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGRecommendTag : NSObject

/** 标签名称 */
@property (nonatomic, copy) NSString *theme_name;
/** 此标签的订阅量 */
@property (nonatomic, assign) NSInteger sub_number;
/** 推荐标签的图片url地址 */
@property (nonatomic, copy) NSString *image_list;

/**
 *  image_list = http://img.spriteapp.cn/ugc/2014/12/08/191154_66536.png,
	theme_id = 122,
	theme_name = DJ,
	is_sub = 0,
	is_default = 0,
	sub_number = 244136
 
 	string
 	string
 is_default	int	是否是默认的推荐标签
 	string
 */

@end
