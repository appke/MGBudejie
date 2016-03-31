//
//  MGTopic.h
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/19.
//  Copyright © 2016年 穆良. All rights reserved.
//  帖子

#import <Foundation/Foundation.h>

@interface MGTopic : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 图像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;

/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 新浪加V */
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;
/** 图片的URL-小 */
@property (nonatomic, copy) NSString *small_image;
/** 图片的URL-大 */
@property (nonatomic, copy) NSString *large_image;
/** 图片的URL-中 */
@property (nonatomic, copy) NSString *middle_image;
/** 帖子的类型 */
@property (nonatomic, assign) MGTopicType type;

/** 播放次数 */
@property (nonatomic, assign) NSInteger playcount;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;


/** 额外辅助属性 */
/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureF;
/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;

/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceF;

/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoF;

@end