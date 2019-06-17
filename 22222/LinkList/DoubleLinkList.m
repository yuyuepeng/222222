//
//  DoubleLinkList.m
//  22222
//
//  Created by 玉岳鹏 on 2019/6/14.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "DoubleLinkList.h"

@implementation DoubleNode

- (instancetype)initWithElement:(id)element prev:(DoubleNode *)prev next:(DoubleNode *)next {
    self = [super init];
    if (self) {
        self.element = element;
        self.prev = prev;
        self.next = next;
    }
    return self;
}

@end

@interface DoubleLinkList()

@property(nonatomic, strong) DoubleNode *first;

@property(nonatomic, strong) DoubleNode *last;

@end



@implementation DoubleLinkList
- (void)clear {
    self.size = 0;
    _first = nil;
    _last =  nil;
    
}
- (id)getWithIndex:(NSInteger)index {
    return [self node:index].element;
}
- (id)setElement:(id)element index:(NSInteger)index {
    DoubleNode *node = [self node:index];
    id old = node.element;
    node.element = element;
    return old;
}

- (void)addElement:(id)element index:(NSInteger)index {
    [self rangeCheckForAdd:index];
    if (index == 0) {
//        self.first = [[Node alloc] initWithElement:element next:self.first];
    }else {
        DoubleNode *prev = [self node:index - 1];
//        prev.next = [[Node alloc] initWithElement:element next:prev.next];
    }
    self.size ++;
}
- (id)removeWithIndex:(NSInteger)index {
    [self rangeCheck:index];
    DoubleNode *node = _first;
    if (self.size == 0) {
        NSLog(@"删除越界，链表已为空");
        return nil;
    }
    if (index == 0) {
        _first = _first.next;
    }else {
        DoubleNode *prev = [self node:index - 1];
        node = prev.next;
        prev.next = node.next;
    }
    self.size --;
    return node.element;
}
- (NSInteger)indexOfElement:(id)element {
    if (element == nil) {
        DoubleNode *node = _first;
        for (NSInteger i = 0; i < self.size; i ++) {
            if (node.element == nil) {
                return i;
            }
            node = node.next;
        }
    }else {
        DoubleNode *node = _first;
        for (NSInteger i = 0; i < self.size; i ++) {
            if (node.element == element) {
                return i;
            }
            node = node.next;
        }
    }
    return ELEMENT_NOT_FOUND;
}
- (DoubleNode *)node:(NSInteger)index {
    [self rangeCheck:index];
    DoubleNode *node = _first;
    for (NSInteger i = 0; i < index; i ++) {
        node = node.next;
    }
    return node;
}
- (NSString *)formatToString {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"size = %ld ,[",(long)self.size]];
    DoubleNode *node = _first;
    for (NSInteger i = 0; i < self.size; i ++) {
        if (i != 0) {
            [string appendString:@","];
        }
        [string appendString:[NSString stringWithFormat:@"%@",node.element]];
        node = node.next;
    }
    [string appendString:@"]"];
    return string;
}
@end
