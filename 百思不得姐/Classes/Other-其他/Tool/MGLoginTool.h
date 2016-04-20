//
//  MGLoginTool.h
//  百思不得姐
//
//  Created by 穆良 on 16/4/21.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGLoginTool : NSObject
/** 存uid */
+ (void)setUid:(NSString *)uid;

/** 取Uid */
+ (NSString *)getUid;
/** 扩展性强些 */
+ (NSString *)getUid:(BOOL)isShowViewController;
@end
