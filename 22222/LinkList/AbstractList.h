//
//  AbstractList.h
//  22222
//
//  Created by 玉岳鹏 on 2019/5/31.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "List.h"

NS_ASSUME_NONNULL_BEGIN

@interface AbstractList : List

@property(nonatomic, assign) NSInteger size;

- (void)rangeCheck:(NSInteger)index;

- (void)outOfBounds:(NSInteger)index;

- (void)rangeCheckForAdd:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
