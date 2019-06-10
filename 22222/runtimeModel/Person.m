//
//  Person.m
//  22222
//
//  Created by 玉岳鹏 on 2019/6/10.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "Person.h"

@implementation Person
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {//控制KVO的触发机制
    BOOL automatic = NO;
    if ([key isEqualToString:@"name"]) {
        automatic = YES;//
    }
    else {
        automatic = [super automaticallyNotifiesObserversForKey:key];
    }
    return automatic;
}
@end
