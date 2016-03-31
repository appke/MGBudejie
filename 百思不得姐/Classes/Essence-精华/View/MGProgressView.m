//
//  MGProgressView.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/25.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGProgressView.h"

@implementation MGProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 3;
    [self.progressLabel setTextColor:[UIColor whiteColor]];
}


- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress*100];
    text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.progressLabel.text = text;
}

@end
