//
//  MGTextField.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/17.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTextField.h"
#import <objc/runtime.h>

static NSString * const MGPlaceholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation MGTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/*
+ (void)initialize
{
 
    unsigned int count = 0;
    // 拷贝出所有成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    class_copyMethodList(<#__unsafe_unretained Class cls#>, <#unsigned int *outCount#>)
    
    for (int i=0; i < count; i++) {
        // 取出成员变量
        Ivar ivar = *(ivars + i);
        
        // 打印成员变量名字
        MGLog(@"%s <-----> %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    // 用到了Copy要释放掉
    free(ivars);
//    unsigned int count = 0;
//    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
//    
//    for (int i=0; i<count; i++) {
//        
//        // 取出属性
//        objc_property_t property = properties[i];
//        // 打印属性名字
//        MGLog(@"%s  <----->  %s", property_getName(property), property_getAttributes(property));
//    }
//    free(properties);
}
*/

- (void)awakeFromNib
{
//    UILabel *placeholder = [self valueForKeyPath:@"placeholderLabel"];
//    placeholder.textColor = [UIColor redColor];
    
    // 设置光标颜色，和文字颜色一致
    self.tintColor = [UIColor whiteColor];
    // 设置不成为第一响应者
    [self resignFirstResponder];
}

/**
 *  当前文本框 聚焦时调用
 */
- (BOOL)becomeFirstResponder
{
    [self setValue:[UIColor whiteColor] forKeyPath:MGPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 *  当前文本框 失去聚焦时调用
 */
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:MGPlaceholderColorKeyPath];
    return [super resignFirstResponder];
}

//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, rect.size.height - 20) withAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor],
//                          NSFontAttributeName : self.font }];
//}
@end
