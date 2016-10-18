//
//  NSString+Price.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/30.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString(Price)

- (NSComparisonResult)comparePrice:(NSString*)price;

/// >
- (BOOL)isGreaterThanPrice:(NSString *)price;

/// >=
- (BOOL)isGreaterThanOrEqualToPrice:(NSString *)price;

/// <
- (BOOL)isLessThanPrice:(NSString *)price;

/// <=
- (BOOL)isLessThanOrEqualToPrice:(NSString *)price;

/// 加
- (NSString *)priceByAdding:(NSString *)number;

/// 减
- (NSString *)priceBySubtracting:(NSString *)number;

/// 乘
- (NSString *)priceByMultiplyingBy:(NSString *)number;

/// 除
- (NSString *)priceByDividingBy:(NSString *)number;

/// 按照舍入规则保留两位小数
- (NSString *)priceByOmit;

@end