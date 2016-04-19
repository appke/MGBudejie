//
//  MGTagButton.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/18.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTagButton.h"

@implementation MGTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = MGTagBg;
        self.titleLabel.font = MGTagFont;
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    self.width += 3 * MGTagMargin;
    self.height = MGTagH;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = MGTagMargin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + MGTagMargin;
}

@end