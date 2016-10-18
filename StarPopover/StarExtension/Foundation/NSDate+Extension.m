//
//  NSDate-Extension.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/25.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "NSDate+Extension.h"


@implementation NSDate (StarCreation)


+ (NSDate *)dateWithFormat:(NSString *)format dateString:(NSString *)dateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:dateString];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}


#pragma mark 格林尼治时间字符串

/// 获取格林尼治字符串 忽略毫秒
- (NSString *)GreenwichString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.000'Z'";
    return [formatter stringFromDate:self];
}

/// 从格林尼治字符串转换成日期 忽略毫秒
- (NSDate *)dateWithGreenwichString:(NSString *)GreenwichString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.000'Z'";
    return [formatter dateFromString:GreenwichString];
}


@end


@implementation NSDate(StarExtended)


#pragma mark - 日历

+ (NSCalendar *)calendar {
    return [NSCalendar currentCalendar];
}


#pragma mark - 取值

/// 时间详情
- (struct WexDateDetail)dateDetail {
    // 年月日
    NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    // 时分秒
    flags = flags | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *comps = [[NSDate calendar] components:flags fromDate:self];
    struct WexDateDetail date = {
        .year = comps.year,
        .month = comps.month,
        .day = comps.day,
        .hour = comps.hour,
        .minute = comps.minute,
        .second = comps.second
    };
    return date;
}

/// 当月有几周
- (NSInteger)numberOfWeeksInMonth {
    return [[NSDate calendar] rangeOfUnit:(NSCalendarUnitWeekOfMonth) inUnit:(NSCalendarUnitMonth) forDate:self].length;
}

/// 当前时间是当月第几周
- (NSInteger)weekNumberInMonth {
    return [[NSDate calendar] components:(NSCalendarUnitWeekOfMonth) fromDate:self].weekOfMonth;
}

/// 当前时间是星期几
- (NSInteger)dayOfWeekInDate {
    return [[NSDate calendar] components:(NSCalendarUnitWeekday) fromDate:self].weekday;
}

/// 当月有多少天
- (NSInteger)numberOfDaysInMonth {
    return [[NSDate calendar] rangeOfUnit:(NSCalendarUnitDay) inUnit:(NSCalendarUnitMonth) forDate:self].length;
}

/// 当月的第一天
- (NSDate *)firstDayInMonth {
    NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [[NSDate calendar] components:flags fromDate:self];
    comps.day = 1;
    return [[NSDate calendar] dateFromComponents:comps];
}

/// 当月的最后一天
- (NSDate *)lastDayInMonth {
    NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [[NSDate calendar] components:flags fromDate:self];
    comps.day = [self numberOfDaysInMonth];
    return [[NSDate calendar] dateFromComponents:comps];
}





#pragma mark - 运算

- (NSDate *)dateByAddingYear:(NSInteger)year {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = year;
    return [[NSDate calendar] dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *)dateByAddingMonth:(NSInteger)month {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.month = month;
    return [[NSDate calendar] dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *)dateByAddingDay:(NSInteger)day {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = day;
    return [[NSDate calendar] dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *)dateByAddingHour:(NSInteger)hour {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.hour = hour;
    return [[NSDate calendar] dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *)dateByAddingMinute:(NSInteger)minute {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.minute = minute;
    return [[NSDate calendar] dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *)dateByAddingSecond:(NSInteger)second {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.second = second;
    return [[NSDate calendar] dateByAddingComponents:comps toDate:self options:0];
}

- (NSDate *)nextDay {
    return [self dateByAddingDay:1];
}

- (NSDate *)dateByRemovingTime {
    NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [[NSDate calendar] components:flags fromDate:self];
    return [[NSDate calendar] dateFromComponents:comps];
}


#pragma mark - 比较

/// >
- (BOOL)isGreaterThanDate:(NSDate *)date {
    NSComparisonResult comparResult = [self compare:date];
    return comparResult == NSOrderedDescending;
}

/// >=
- (BOOL)isGreaterThanOrEqualToDate:(NSDate *)date {
    NSComparisonResult comparResult = [self compare:date];
    return comparResult == NSOrderedDescending || comparResult == NSOrderedSame;
}

/// <
- (BOOL)isLessThanDate:(NSDate *)date {
    NSComparisonResult comparResult = [self compare:date];
    return comparResult == NSOrderedAscending;
}

/// <=
- (BOOL)isLessThanOrEqualToDate:(NSDate *)date {
    NSComparisonResult comparResult = [self compare:date];
    return comparResult == NSOrderedAscending || comparResult == NSOrderedSame;
}


/// 当前月份与指定时间的月份是否相同
- (BOOL)isSameMonthWithDate:(NSDate *)date {
    NSCalendarUnit flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps1 = [[NSDate calendar] components:flags fromDate:self];
    NSDateComponents *comps2 = [[NSDate calendar] components:flags fromDate:date];
    return comps1.month == comps2.month;
}


/// 当前时间是否为今天
- (BOOL)isToday {
    //    return [[[NSDate date] dateByRemovingTime] isEqualToDate:[self dateByRemovingTime]];
    return self.dateDetail.day == [NSDate date].dateDetail.day;
}

/// 当前时间是否已经过去
- (BOOL)isPast {
    return [self isLessThanDate:[NSDate date]];
}

/// 当前时间是否是将来
- (BOOL)isFuture {
    return [self isGreaterThanDate:[NSDate date]];
}

/// 今天是否已经过去
- (BOOL)isDayPast {
    return self.dateDetail.day < [NSDate date].dateDetail.day;
}

@end

#pragma mark - 字符串转时间

@implementation NSString (Date)

- (NSDate *)dateWithFormat:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:self];
}

@end


@implementation NSDate (Convertor)

/**
 *  获取传入时间共有（x小时x分钟x秒），例：传入3661秒，获得（1小时1分1秒）
 */
+ (void)getHour:(NSInteger *)hour minite:(NSInteger *)minite second:(NSInteger *)second fromSurplusTime:(NSTimeInterval)surplusTime {
    
    NSInteger surSecond = (NSInteger)surplusTime;
    //    NSInteger milli = (surplusTime - surSecond) * 1000;
    
    NSInteger aHour = 60 * 60;
    NSInteger aMinite = 60;
    
    *hour = surSecond / aHour;
    surSecond = surSecond % aHour;
    
    if (surSecond != 0) {
        *minite = surSecond / aMinite;
    }
    
    surSecond = surSecond % aMinite;
    if (surSecond != 0) {
        *second = surSecond;
    }
    
}
@end
