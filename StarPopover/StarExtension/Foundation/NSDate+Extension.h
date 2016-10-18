//
//  NSDate-Extension.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/25.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>


struct WexDateDetail {
    NSInteger year;
    NSInteger month;
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    NSInteger second;
};

// 暂未测试完全，将持续在使用中完成测试，如果有任何问题随时联系作者

@interface NSDate (StarCreation)

+ (NSDate *)dateWithFormat:(NSString *)format dateString:(NSString *)dateString;
- (NSString *)stringWithFormat:(NSString *)format;

#pragma mark 格林尼治时间字符串

/// 获取格林尼治字符串 忽略毫秒
- (NSString *)GreenwichString;
/// 从格林尼治字符串转换成日期 忽略毫秒
- (NSDate *)dateWithGreenwichString:(NSString *)GreenwichString;

@end


@interface NSDate(StarExtended)

#pragma mark - 日历

/// 默认日历
+ (NSCalendar *)calendar;


#pragma mark - 取值

/// 时间详情
//- (struct WexDateDetail)dateDetail;
@property (nonatomic, assign, readonly) struct WexDateDetail dateDetail;

/// 当月有几周
//- (NSInteger)numberOfWeeksInMonth;
@property (nonatomic, assign, readonly) NSInteger numberOfWeeksInMonth;

/// 当前时间是当月第几周
//- (NSInteger)weekNumberInMonth;
@property (nonatomic, assign, readonly) NSInteger weekNumberInMonth;

/// 当前时间是星期几
//- (NSInteger)dayOfWeekInDate;
@property (nonatomic, assign, readonly) NSInteger dayOfWeekInDate;

/// 当月有多少天
//- (NSInteger)numberOfDaysInMonth;
@property (nonatomic, assign, readonly) NSInteger numberOfDaysInMonth;

/// 当月的第一天
//- (NSDate *)firstDayInMonth;
@property (nonatomic, strong, readonly) NSDate *firstDayInMonth;

/// 当月的最后一天
//- (NSDate *)lastDayInMonth;
@property (nonatomic, strong, readonly) NSDate *lastDayInMonth;





#pragma mark - 运算

- (NSDate *)dateByAddingYear:(NSInteger)year;

- (NSDate *)dateByAddingMonth:(NSInteger)month;

- (NSDate *)dateByAddingDay:(NSInteger)day;

- (NSDate *)dateByAddingHour:(NSInteger)hour;

- (NSDate *)dateByAddingMinute:(NSInteger)minute;

- (NSDate *)dateByAddingSecond:(NSInteger)second;

- (NSDate *)nextDay;

- (NSDate *)dateByRemovingTime;


#pragma mark - 比较

/// >
- (BOOL)isGreaterThanDate:(NSDate *)date;

/// >=
- (BOOL)isGreaterThanOrEqualToDate:(NSDate *)date;

/// <
- (BOOL)isLessThanDate:(NSDate *)date;

/// <=
- (BOOL)isLessThanOrEqualToDate:(NSDate *)date;

/// 当前月份与指定时间的月份是否相同
- (BOOL)isSameMonthWithDate:(NSDate *)date;


/// 当前时间是否为今天
@property (nonatomic, assign, readonly) BOOL isToday;

/// 当前时间是否已经过去
@property (nonatomic, assign, readonly) BOOL isPast;

/// 当前时间是否是将来
@property (nonatomic, assign, readonly) BOOL isFuture;

/// 今天是否已经过去
@property (nonatomic, assign, readonly) BOOL isDayPast;



@end

@interface NSString (Date)


- (NSDate *)dateWithFormat:(NSString *)format;

@end


@interface NSDate (Convertor)

/**
 *  获取传入时间共有（x小时x分钟x秒），例：传入3661秒，获得（1小时1分1秒）
 */
+ (void)getHour:(NSInteger *)hour minite:(NSInteger *)minite second:(NSInteger *)second fromSurplusTime:(NSTimeInterval)surplusTime;

@end
