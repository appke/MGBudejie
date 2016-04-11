//
//  UIImage+MGExtension.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/18.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "UIImage+MGExtension.h"

@implementation UIImage (MGExtension)

- (instancetype)circleImage
{
    // 开启上下文
//    UIGraphicsBeginImageContext(self.size);
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获得上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 画圆
    CGRect rect = {CGPointZero, self.size};
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪
    CGContextClip(context);
    
    // 将下载好的图片画到圆上
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}
@end
