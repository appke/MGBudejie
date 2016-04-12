//
//  MGMeCell.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/12.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGMeCell.h"

@implementation MGMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // 设置cell的背景图片
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        // 指示器
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 没有图片的
    if (self.imageView == nil) return;
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.height * 0.5;
    
    // textLabel和iamgeView相距太远
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
}

//- (void)setFrame:(CGRect)frame
//{
//    NSLog(@"%@", NSStringFromCGRect(self.frame));
//    
//    frame.origin.y -= (35 - MGTopicCellMargin);
//    
//    [super setFrame:frame];
//}

@end
