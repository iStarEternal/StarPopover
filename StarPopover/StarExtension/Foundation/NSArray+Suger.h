//
//  NSArray+Language.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/6/6.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (Suger)

- (NSArray *)map:(id (^)(ObjectType element))block;

- (NSArray<ObjectType> *)filter:(BOOL (^)(ObjectType element))block;

- (NSArray<ObjectType> *)reversed;

- (id)reduce:(id)initial combine:(id (^)(id lastObj, id currentEle))combine;

- (ObjectType)elementWithComparator:(BOOL(^)(ObjectType element))comparator;


- (NSArray<ObjectType> *)sorted:(BOOL (^)(ObjectType previous, ObjectType current))comparator;

- (void)forEach:(void (^)(NSInteger i, ObjectType item, BOOL *stop))forEach;


- (NSArray<ObjectType> *)star_removedObject:(ObjectType)anObject;
- (NSArray<ObjectType> *)star_removedLastObject;
- (NSArray<ObjectType> *)star_removedObjectAtIndex:(NSUInteger)index;

- (NSArray<ObjectType> *)star_addedObject:(ObjectType)anObject;
- (NSArray<ObjectType> *)star_insertedObject:(ObjectType)anObject atIndex:(NSUInteger)index;

@end

@interface NSDictionary<ObjectKeyType, ObjectValueType> (StarSuger)

- (NSDictionary<ObjectKeyType, ObjectValueType> *)filter:(BOOL (^)(ObjectKeyType key))block;

@end
