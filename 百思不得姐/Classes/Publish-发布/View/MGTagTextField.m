//
//  MGTagTextField.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTagTextField.h"

@implementation MGTagTextField

// 也能在这个方法中监听键盘输入,如“换行”
- (void)insertText:(NSString *)text
{
    [super insertText:text];
    
    MGLog(@"-%d-", [text isEqualToString:@"\n"]);
}

- (void)deleteBackward
{
    !self.deleteBlock ? : self.deleteBlock();
    
    [super deleteBackward];
    
    MGLogFunc;
}

//- (void)deleteBackward
//{
//    //    [super deleteBackward];
//    
//    // 一旦block有值就调用
//    self.deleteBlock ? : self.deleteBlock();
//    MGLogFunc;
//}


@end
