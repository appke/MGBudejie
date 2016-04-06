//
//  MGTopic.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/19.
//  Copyright © 2016年 穆良. All rights reserved.
//  

#import "MGTopic.h"
#import <MJExtension.h>
#import "MGComment.h"

@implementation MGTopic
{
    CGFloat _cellHeight;
//    CGRect _pictureF;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
//             @"top_cmt" : [MGComment class]
             @"top_cmt" : @"MGComment"
             };
}


- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *create = [fmt dateFromString:_create_time];

    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            // 从大时间开始判断起
            NSDateComponents *cmps = [create deltaWithNow];
            if (cmps.hour >= 1) { // 1小时前
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1分钟前
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
            
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        
    } else { // 不是今年
        return _create_time;
    }
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4*MGTopicCellMargin, MAXFLOAT);

        // 文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
//        MGLog(@"-----%f", textH);
        
        // cell的高度
        // 文字部分的高度
        _cellHeight = MGTopicCellTextY + textH + MGTopicCellMargin;
        
        // 根据帖子类型，计算cell的高度
        if (self.type == MGTopicTypePicture) { // 图片帖子
            
            // 图片的宽度
            CGFloat pictureW = maxSize.width;
            // 图片的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            
            // 图片高度过长
            if (pictureH > MGTopicCellPictureMaxH) {
                pictureH = MGTopicCellPictureBreakH;
                self.bigPicture = YES; // 为大图
            }
            
            // 计算图片控件的frame
            CGFloat pictureX = MGTopicCellMargin;
            CGFloat pictureY = MGTopicCellTextY + textH + MGTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + MGTopicCellMargin;
        } else if (self.type == MGTopicTypeVoice){ // 声音
            
            CGFloat voiceX = MGTopicCellMargin;
            CGFloat voiceY = MGTopicCellTextY + textH + MGTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + MGTopicCellMargin;
        } else if (self.type == MGTopicTypeVideo) { // 视频
            
            CGFloat videoX = MGTopicCellMargin;
            CGFloat videoY = MGTopicCellTextY + textH + MGTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + MGTopicCellMargin;
        }
        
        // 底部工具条高度(cell之间的分割用)
        _cellHeight += MGTopicCellBottomBarH + MGTopicCellMargin;
        
    }
    return _cellHeight;
}


@end
