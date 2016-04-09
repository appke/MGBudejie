//
//  MGTopicViewCell.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/20.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTopicCell.h"
#import "MGTopic.h"
#import <UIImageView+WebCache.h>
#import "MGTopicPictureView.h"
#import "MGTopicVoiceView.h"
#import "MGTopicVideoView.h"
#import "MGComment.h"
#import "MGUser.h"


@interface MGTopicCell ()
/** 图像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;

/** 帖子中间的图片 */
@property (nonatomic, weak) MGTopicPictureView *pictureView;

/** 帖子中间的声音 */
@property (nonatomic, weak) MGTopicVoiceView *voiceView;

/** 帖子中间的视频 */
@property (nonatomic, weak) MGTopicVideoView *videoView;

/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/** 最热评论整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation MGTopicCell

- (void)awakeFromNib {

    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    // 选中是的背景不变
//    self.selectedBackgroundView = bgView;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (MGTopicPictureView *)pictureView
{
    if (!_pictureView) {
        MGTopicPictureView *pictureView = [MGTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

#pragma mark - 懒加载 一定要添加到cell中
- (MGTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        MGTopicVoiceView *voiceView = [MGTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (MGTopicVideoView *)videoView
{
    if (!_videoView) {
        MGTopicVideoView *videoView = [MGTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)setTopic:(MGTopic *)topic
{
    _topic = topic;
    
    topic.sina_v = (int)arc4random_uniform(10) % 2;
    // 新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    
    // 设置其他控件
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.creatTimeLabel.text = topic.create_time;

    // 设置按钮文字
    [self setButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    // 设置帖子的文字内容
    self.text_label.text = topic.text;
    
    // 根据数据模型(帖子类型) 添加对应内容到cell中间
    if (topic.type == MGTopicTypePicture) { // 图片帖子
        
        self.pictureView.hidden = NO;
        
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
    } else if (topic.type == MGTopicTypeVoice) { // 声音帖子

        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;

        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        
    } else if (topic.type == MGTopicTypeVideo) { // 视频帖子
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        
        
    } else if (topic.type == MGTopicTypeWord){ // 段子帖子 (写全，防止以后再加)
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    // 处理最热评
//    MGComment *cmt = [topic.top_cmt firstObject];
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        // 拼接用户名 : 评论内容
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", topic.top_cmt.user.username, topic.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
}

- (void)setButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    // 利用placeholder不用新开变量
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
}

/**
 *  拦截frame的设置
 */
- (void)setFrame:(CGRect)frame
{
//    static CGFloat margin = 10;
    frame.origin.x = MGTopicCellMargin;
    frame.size.width -= 2 * MGTopicCellMargin;
//    frame.size.height -= MGTopicCellMargin;
    frame.size.height = self.topic.cellHeight - MGTopicCellMargin;
    frame.origin.y += MGTopicCellMargin;
    
    [super setFrame:frame];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)more:(id)sender {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏", @"举报", nil];
    [sheet showInView:self.window];
}

@end
