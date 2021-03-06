//
//  MGTagTextField.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTagTextField.h"

@implementation MGTagTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.placeholder = @"多个标签用逗号或换行隔开";
        [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
        self.height = MGTagH;
        self.font = MGTagFont;
    }
    return self;
}


// 也能在这个方法中监听键盘输入,如“换行”
- (void)insertText:(NSString *)text
{
    [super insertText:text];
//    MGLog(@"-%d-", [text isEqualToString:@"\n"]);
}

- (void)deleteBackward
{
    // 一旦block有值就调用
    !self.deleteBlock ? : self.deleteBlock();
    
    [super deleteBackward];
    
//    MGLogFunc;
}


@end
