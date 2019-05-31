//
//  AbstractList.m
//  22222
//
//  Created by 玉岳鹏 on 2019/5/31.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "AbstractList.h"

@interface AbstractList ()



@end

@implementation AbstractList

- (NSInteger)size {
    return _size;
}
- (BOOL)isEmpty {
    return _size == 0;
}
- (BOOL)containsElement:(id)element {
    return [self indexOfElement:element] == ELEMENT_NOT_FOUND;
}
- (void)addElement:(id)element {
    [self addElement:element index:_size];
}
- (void)outOfBounds:(NSInteger)index {
    NSLog(@"index + %ld + size + %ld",index,_size);
}
- (void)rangeCheck:(NSInteger)index {
    if (index<0 || index >= _size) {
        [self outOfBounds:index];
    }
}
- (void)rangeCheckForAdd:(NSInteger)index {
    if (index<0 || index > _size) {
        [self outOfBounds:index];
    }
}
@end
