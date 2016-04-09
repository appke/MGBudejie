//
//  MGCommentCell.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/10.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGCommentCell.h"
#import "MGComment.h"
#import "MGUser.h"
#import <UIImageView+WebCache.h>

@interface MGCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end


@implementation MGCommentCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setComment:(MGComment *)comment
{
    _comment = comment;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.sexImageView.image = [comment.user.sex isEqualToString:MGUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.usernameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    
    self.contentLabel.text = comment.content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
