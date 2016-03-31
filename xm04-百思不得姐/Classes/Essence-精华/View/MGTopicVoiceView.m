//
//  MGTopicVoiceView.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/28.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTopicVoiceView.h"
#import "MGTopic.h"
#import <UIImageView+WebCache.h>
#import "MGShowPictureViewController.h"

@interface MGTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@end

@implementation MGTopicVoiceView
/**
 *  类方法创建视图
 */
+ (instancetype)voiceView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
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

- (void)setTopic:(MGTopic *)topic
{
    _topic = topic;
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    // 时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", second, minute];
}

@end
