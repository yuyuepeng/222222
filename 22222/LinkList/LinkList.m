//
//  LinkList.m
//  22222
//
//  Created by 扶摇先生 on 2019/6/3.
//  Copyright © 2019年 玉岳鹏. All rights reserved.
//

#import "LinkList.h"

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


@interface LinkList()

@end

@implementation LinkList


//- (Node *)node:(NSInteger)index {
//    []
//    return <#expression#>
//}
@end
