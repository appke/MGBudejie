//
//  MGPlaceholderTextView.m
//  百思不得姐
//
//  Created by 穆良 on 16/4/15.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGPlaceholderTextView.h"

@implementation MGPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置默认的textView属性
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = [UIColor grayColor];
        self.alwaysBounceVertical = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
        
        [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    }
    return self;
}

/**
 *  文字改变调用
 */
- (void)textDidChange
{
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  绘制占位文字(每次调用drawRect:之前,会自动清除之前绘制的内容)
 */
- (void)drawRect:(CGRect)rect {
    
    // {{0, -64}, {320, 568}}
//    MGLog(@"%@", NSStringFromCGRect(rect));
    // 如果有文字,直接返回,不绘制
//    if (self.text.length || self.attributedText.length) return;
    if (self.hasText) return;
    
    // 处理rect
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width -= 2 * rect.origin.x;
    
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}

#pragma mark - 别人可修改我的属性
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    // 重新再画一遍
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    // 这里要用copy,用的是copy协议
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}


- (void)setFont:(UIFont *)font
{
    // 要先调用父类方法, 这个属性不是你的textView的,给父类赋一个值
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
@end
