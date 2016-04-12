//
//  MGSquareButton.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/13.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGSquareButton.h"

static CGFloat const rate = 0.60;
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
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.height = self.height * 0.7;
    self.imageView.width = self.imageView.height;
    self.imageView.x = (self.width - self.imageView.width) * 0.5;
    self.imageView.y = 0;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.height * rate;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height * (1-rate);
    
}
@end
