//
//  MGSquare.h
//  百思不得姐
//
//  Created by 穆良 on 16/4/12.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGSquare : NSObject
/** 方块id */
@property (nonatomic, assign) NSInteger ID;
/** 方块手机地址 */
@property (nonatomic, copy) NSString *url;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 图像 */
@property (nonatomic, copy) NSString *icon;

@end
