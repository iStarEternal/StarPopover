//
//  NSString+Price.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/30.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "NSString+Money.h"


@implementation NSString (Price)

#pragma mark - 金额比较

// 金额大小比较
- (NSComparisonResult)comparePrice:(NSString*)price {
    NSDecimalNumber* priceNumber1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber* priceNumber2 = [NSDecimalNumber decimalNumberWithString:price];
    NSComparisonResult result = [priceNumber1 compare:priceNumber2];
    return result;
}

/// >
- (BOOL)isGreaterThanPrice:(NSString *)price {
    NSComparisonResult comparResult = [self comparePrice:price];
    return comparResult == NSOrderedDescending;
}

/// >=
- (BOOL)isGreaterThanOrEqualToPrice:(NSString *)price {
    NSComparisonResult comparResult = [self comparePrice:price];
    return comparResult == NSOrderedDescending || comparResult == NSOrderedSame;
}

/// <
- (BOOL)isLessThanPrice:(NSString *)price {
    NSComparisonResult comparResult = [self comparePrice:price];
    return comparResult == NSOrderedAscending;
}

/// <=
- (BOOL)isLessThanOrEqualToPrice:(NSString *)price {
    NSComparisonResult comparResult = [self comparePrice:price];
    return comparResult == NSOrderedAscending || comparResult == NSOrderedSame;
}


#pragma mark - 加减乘除 各保留两位

// 保留小数，默认保存两位
- (unsigned short)pointOmit {
    return 2;
}

// 保留小数的Format -- 暂未使用
- (NSString *)pointOmitFormat {
    switch ([self pointOmit]) {
            
        case 0:
            return @"%.0f";
            break;
            
        case 1:
            return @"%.1f";
            break;
            
        case 2:
            return @"%.2f";
            break;
            
        case 3:
            return @"%.3f";
            break;
            
        case 4:
            return @"%.4f";
            break;
            
        case 5:
            return @"%.5f";
            break;
            
        case 6:
            return @"%.6f";
            break;
            
        default:
            return @"%.2f";
            break;
    }
}

// 舍入规则，默认只入不舍
- (NSRoundingMode)roundingMode {
    return NSRoundUp;
}

// 配置舍入规则 以及小数点后保留几位
- (NSDecimalNumberHandler *)behavior {
    return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:self.roundingMode
                                                                  scale:self.pointOmit
                                                       raiseOnExactness:false
                                                        raiseOnOverflow:false
                                                       raiseOnUnderflow:false
                                                    raiseOnDivideByZero:false];
}

- (NSString *)priceByAdding:(NSString *)number {
    
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    
    NSDecimalNumber *result = [numberA decimalNumberByAdding:numberB withBehavior:self.behavior];
    
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)priceBySubtracting:(NSString *)number {
    
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    
    NSDecimalNumber *result = [numberA decimalNumberBySubtracting:numberB withBehavior:self.behavior];
    
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)priceByMultiplyingBy:(NSString *)number {
    
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    
    NSDecimalNumber *result = [numberA decimalNumberByMultiplyingBy:numberB withBehavior:self.behavior];
    
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)priceByDividingBy:(NSString *)number {
    
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    
    NSDecimalNumber *result = [numberA decimalNumberByDividingBy:numberB withBehavior:self.behavior];
    
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)priceByOmit {
    return [self priceByAdding:@"0"];
}

@end
