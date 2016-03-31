//
//  NSDate+MGExtension.h
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/20.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MGExtension)
/** 是否是今天 */
- (BOOL)isToday;
/** 是否是昨天 */
- (BOOL)isYesterday;
/** 是否是今年 */
- (BOOL)isThisYear;
/** 获得与当前时间的差距 */
- (NSDateComponents *)deltaWithNow;
/** 返回只包含年月日的时间 */
- (NSDate *)dateWithYMD;
@end
