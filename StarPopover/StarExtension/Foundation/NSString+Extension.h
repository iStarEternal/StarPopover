//
//  NSString+Extension.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/21.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 暂未测试完全，将持续在使用中完成测试，如果有任何问题随时联系作者
@interface NSString(Extensions)
{}



@property (nonatomic, strong, readonly) NSNumber *numberValue;

@property (nonatomic, assign, readonly) NSRange fullRange;


- (CGSize)sizeWithFont:(UIFont*)font andMaxSize:(CGSize)maxSize;

@end

@interface NSString (StarCheck)

+ (BOOL)isNullOrEmpty:(NSString*)key;
+ (BOOL)isNullOrWhiteSpace:(NSString*)key;

// if self is nil, return false
// if self is empty, return false
// other return ture
@property (nonatomic, assign, readonly) BOOL isNotEmpty;
@property (nonatomic, assign, readonly) BOOL isNotWhiteSpace;

@property (nonatomic, assign, readonly) BOOL hasCharecter;
@property (nonatomic, assign, readonly) BOOL hasCharecterExcludeWhiteSpace;

// It's Deprecated, if self is nil, will return false, It's not expected value;
@property (nonatomic, assign, readonly) BOOL isEmpty;
@property (nonatomic, assign, readonly) BOOL isWhiteSpace;


@end


@interface NSString (StarLocalized)

@property (nonatomic, strong, readonly) NSString *localizedString;

- (NSString *)localizedStringWithComment:(NSString*)comment;

@end
