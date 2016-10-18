//
//  NSString+Extension.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/21.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString(Extensions)

- (NSNumber *)numberValue {
    return @(self.doubleValue);
}


- (NSString *)stringWithFormat:(NSArray<NSString *> *)format {
    
    //    va_list argumentList;
    
    //    va_start(<#ap#>, <#param#>)
    
    return [NSString stringWithFormat:self, format];
}


- (CGSize)sizeWithFont:(UIFont*)font andMaxSize:(CGSize)maxSize {
    return [self boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : font} context:nil].size;
    
}

- (NSRange)fullRange {
    return [self rangeOfString:self];
}

@end



@implementation NSString (StarCheck)



+ (BOOL)isNullOrEmpty:(NSString*)key {
    if (key == nil) {
        return true;
    }
    return [key isEmpty];
}

+ (BOOL)isNullOrWhiteSpace:(NSString*)key {
    if (key == nil) {
        return true;
    }
    if (![key isKindOfClass:[NSString class]]) {
        return true;
    }
    return [key isWhiteSpace];
}


- (BOOL)isNotEmpty {
    return !self.isEmpty;
}

- (BOOL)isNotWhiteSpace {
    return !self.isWhiteSpace;
}

- (BOOL)hasCharecter {
    return self.isNotEmpty;
}

- (BOOL)hasCharecterExcludeWhiteSpace {
    return self.isNotWhiteSpace;
}

- (BOOL)isEmpty {
    return [self isEqualToString:@""];
}

- (BOOL)isWhiteSpace {
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEmpty];
}

@end


@implementation NSString (StarLocalized)

- (NSString *)localizedString {
    return [self localizedStringWithComment:nil];
}

- (NSString *)localizedStringWithComment:(NSString*)comment {
    return NSLocalizedString(self, comment);
}

@end