//
//  NSArray+Language.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/6/6.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "NSArray+Suger.h"

@implementation NSArray (Suger)


- (NSArray *)map:(id (^)(id))block {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.count; i++) {
        [array addObject:block(self[i])];
    }
    return [array copy];
}

- (NSArray *)filter:(BOOL (^)(id))block {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.count; i++) {
        if (block(self[i])) {
            [arr addObject:self[i]];
        }
    }
    return [arr copy];
}

- (id)reduce:(id)initial combine:(id (^)(id, id))combine {
    for (int i = 0; i < self.count; i++) {
        initial = combine(initial, self[i]);
    }
    return initial;
}

- (NSArray *)reversed {
    return [[self reverseObjectEnumerator] allObjects];
}

- (id)elementWithComparator:(BOOL(^)(id))comparator {
    for (int i = 0; i < self.count; i++) {
        if (comparator(self[i])) {
            return self[i];
        }
    }
    return nil;
}

- (NSArray *)sorted:(BOOL (^)(id, id))comparator {
    if (!comparator) {
        return self;
    }
    return [self sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return comparator(obj1, obj2) ? NSOrderedAscending : NSOrderedDescending;
    }];
}

- (void)forEach:(void (^)(NSInteger i, id item, BOOL *stop))forEach {
    
    
    //    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        forEach(idx, obj, stop);
    //    }];
    
    
    BOOL stop = false;
    
    NSInteger idx = 0;
    
    NSEnumerator *enumerator = self.objectEnumerator;
    id obj = nil;
    while (obj = [enumerator nextObject]) {
        forEach(idx, obj, &stop);
        if (stop) return;
        idx++;
    }
    
}




- (NSArray *)star_removedObject:(id)anObject {
    NSMutableArray *arrM = self.mutableCopy;
    [arrM removeObject:anObject];
    return arrM.copy;
}

- (NSArray *)star_removedLastObject {
    NSMutableArray *arrM = self.mutableCopy;
    [arrM removeLastObject];
    return arrM.copy;
}

- (NSArray *)star_removedObjectAtIndex:(NSUInteger)index {
    NSMutableArray *arrM = self.mutableCopy;
    [arrM removeObjectAtIndex:index];
    return arrM.copy;
}


- (NSArray *)star_addedObject:(id)anObject {
    NSMutableArray *arrM = self.mutableCopy;
    [arrM addObject:anObject];
    return arrM.copy;
}

- (NSArray *)star_insertedObject:(id)anObject atIndex:(NSUInteger)index {
    NSMutableArray *arrM = self.mutableCopy;
    [arrM insertObject:anObject atIndex:index];
    return arrM.copy;
}

@end

@implementation NSDictionary (StarSuger)

- (NSDictionary *)filter:(BOOL (^)(id))block {
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    for (int i = 0; i < self.count; i++) {
        if (block(self.allKeys[i])) {
            dictM[self.allKeys[i]] = self[self.allKeys[i]];
        }
    }
    return [dictM copy];
}

@end
