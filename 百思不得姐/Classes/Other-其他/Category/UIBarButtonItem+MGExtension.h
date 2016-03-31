//
//  UIBarButtonItem+MGExtension.h
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/9.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MGExtension)
/**
 *  快速创建一个UIBarButtonItem
 *
 *  @param image     普通图片
 *  @param highImage 高亮图片
 *  @param target    那个类执行
 *  @param action    点击执行的方法
 *
 *  @return 返回一个UIBarButtonItem
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
