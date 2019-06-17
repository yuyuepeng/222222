//
//  SingleLinkList.m
//  22222
//
//  Created by 扶摇先生 on 2019/6/3.
//  Copyright © 2019年 玉岳鹏. All rights reserved.
//

#import "SingleLinkList.h"

@implementation Node

- (instancetype)initWithElement:(id)element next:(Node *)next {
    self = [super init];
    if (self) {
        self.element = element;
        self.next = next;
    }
    return self;
}

@end


@interface SingleLinkList()

@property(nonatomic, strong) Node *first;

@end

@implementation SingleLinkList

- (void)clear {
    self.size = 0;
    _first = nil;
}
- (id)getWithIndex:(NSInteger)index {
    return [self node:index].element;
}
- (id)setElement:(id)element index:(NSInteger)index {
    Node *node = [self node:index];
    id old = node.element;
    node.element = element;
    return old;
}

- (void)addElement:(id)element index:(NSInteger)index {
    [self rangeCheckForAdd:index];
    if (index == 0) {
        self.first = [[Node alloc] initWithElement:element next:self.first];
    }else {
        Node *prev = [self node:index - 1];
        prev.next = [[Node alloc] initWithElement:element next:prev.next];
    }
    self.size ++;
}
- (id)removeWithIndex:(NSInteger)index {
    [self rangeCheck:index];

    Node *node = _first;
    if (index == 0) {
        _first = _first.next;
    }else {
        Node *prev = [self node:index - 1];
        node = prev.next;
        prev.next = node.next;
    }
    self.size --;
    return node.element;
}
- (NSInteger)indexOfElement:(id)element {
    if (element == nil) {
        Node *node = _first;
        for (NSInteger i = 0; i < self.size; i ++) {
            if (node.element == nil) {
                return i;
            }
            node = node.next;
        }
    }else {
        Node *node = _first;
        for (NSInteger i = 0; i < self.size; i ++) {
            if (node.element == element) {
                return i;
            }
            node = node.next;
        }
    }
    return ELEMENT_NOT_FOUND;
}
- (Node *)node:(NSInteger)index {
    [self rangeCheck:index];
    Node *node = _first;
    for (NSInteger i = 0; i < index; i ++) {
        node = node.next;
    }
    return node;
}
- (NSString *)formatToString {
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"size = %ld ,[",(long)self.size]];
    Node *node = _first;
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
