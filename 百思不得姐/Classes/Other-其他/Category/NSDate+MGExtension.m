//
//  NSDate+MGExtension.m
//  xm04-百思不得姐
//
//  Created by 穆良 on 16/3/20.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "NSDate+MGExtension.h"

@implementation NSDate (MGExtension)


/** 是否为今天，年月日一样 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**  是否是昨天 */
// 先把时分秒去掉，只有年月日的时间，相差多少天
- (BOOL)isYesterday
{
    // 2014-12-31  和 2015-01-01只相差一天
    // 2014-05-01 18:45:56
    // 2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 2014-04-30 19:23:49
    // 2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    // 只关注天数的差别 获得nowDate和selfDate的差距
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calender components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];

    return cmps.day == 1;
}

/** 是否为今年 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

/**  获得与当前时间的差距，谁调用谁就是self */
- (NSDateComponents *)deltaWithNow
{
    // 2014-09-10 18:40:30
    // 2014-09-10 19:50:50
    // 1h 10m 20s
    NSCalendar *calender = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calender components:unit fromDate:self toDate:[NSDate date] options:0];
}

/**  返回只包含年月日的时间 */
- (NSDate *)dateWithYMD
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    return [fmt dateFromString:dateStr];
}

@end
