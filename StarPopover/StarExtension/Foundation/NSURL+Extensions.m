//
//  NSURL+Extensions.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/6/13.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "NSURL+Extensions.h"

@implementation NSURL (Extensions)


- (NSDictionary *)dictionaryFromQueryUsingEncoding:(NSStringEncoding)encoding {
    
    NSCharacterSet *delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary *pairs = [NSMutableDictionary dictionary];
    NSScanner *scanner = [[NSScanner alloc] initWithString:self.query];

    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString *key = [[kvPair objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString *value = [[kvPair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [pairs copy];
}


- (NSDictionary *)queryDictionary {
    
    NSArray *keyValues = [self.query componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    
    for (NSString *item in keyValues) {
        NSArray *keyValue = [item componentsSeparatedByString:@"="];
        NSString *key = keyValue[0];
        NSString *value = keyValue[1];
        [dictM setObject:value forKey:key];
    }
    return [dictM copy];
}



@end
