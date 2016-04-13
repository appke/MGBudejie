//
//  MGSquareButton.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/13.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGSquareButton.h"
#import "MGSquare.h"
#import <UIButton+WebCache.h>

@implementation MGSquareButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
    // 屏蔽内部细节
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    self.imageView.backgroundColor = [UIColor redColor];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = self.width * 0.2;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.x = (self.width - self.imageView.width) * 0.5;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquare:(MGSquare *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    // 利用SDWebImage给按钮设置image
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
