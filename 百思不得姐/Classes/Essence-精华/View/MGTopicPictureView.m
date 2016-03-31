//
//  MGTopicPictureView.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/24.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTopicPictureView.h"
#import "MGTopic.h"
#import <UIImageView+WebCache.h>
#import "MGProgressView.h"
#import "MGShowPictureViewController.h"

@interface MGTopicPictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/** 进度条控件 */
@property (weak, nonatomic) IBOutlet MGProgressView *progressView;

@end

@implementation MGTopicPictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(MGTopic *)topic
{
    _topic = topic;
    
    self.progressView.hidden = YES;
    // 立马显示最新的进度值(防止网速过慢, 导致显示的是其他图片的下载进度)
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    // 设置图片
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    [self.imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        // 调用很频繁
        self.progressView.hidden = NO;
        // 计算进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:topic.pictureProgress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) { // 下载完 调一次
        self.progressView.hidden = YES;
        
        // 如果是大图片，才需要绘图处理
        if (topic.isBigPicture == NO) return;
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        
        CGFloat imageW = topic.pictureF.size.width;
        CGFloat imageH = imageW * image.size.height / image.size.width;
        // 将下载完的image绘制到 图形上下文中
        [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
        
        // 得到图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
    }];
    
    // 判断是否为gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否显示"点击查看全图"
    if (topic.isBigPicture) { // 是大图
        self.seeBigButton.hidden = NO;
//        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        self.imageView.contentMode = UIViewContentModeTop;
        
    } else {
        self.seeBigButton.hidden = YES;
//        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

-(void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}

#pragma mark - 显示大图
- (void)showPicture
{
    // 显示大图
    MGShowPictureViewController *showPicture = [[MGShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

@end
