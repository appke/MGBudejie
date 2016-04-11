//
//  MGRecommendUserCell.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/10.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGRecommendUserCell.h"
#import "MGRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface MGRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;
@end


@implementation MGRecommendUserCell


- (void)setUser:(MGRecommendUser *)user
{
    _user = user;
    
//    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    [self.headerImageView setHeader:user.header];
    
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
