//
//  MGUser.h
//  百思不得姐
//
//  Created by 穆良 on 16/4/4.
//  Copyright © 2016年 穆良. All rights reserved.
//用户模型

#import <Foundation/Foundation.h>

@interface MGUser : NSObject
/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
@end
