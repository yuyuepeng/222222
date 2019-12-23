//
//  Person.m
//  22222
//
//  Created by 玉岳鹏 on 2019/6/10.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)showObjectInfo {
    NSLog(@"Object instance address is %p, Object isa content is %p",self,*((void **)(__bridge void *)self));
}
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {//控制KVO的触发机制
    BOOL automatic = NO;
    if ([key isEqualToString:@"name"]) {
        automatic = YES;//返回yes是调用kvo的代理方法   返回no是不调用
    }
    else {
        automatic = [super automaticallyNotifiesObserversForKey:key];
    }
    return automatic;
}

+ (void)load {
    
}
+ (void)sayHelloToAmy {
    NSLog(@"hello Amy");
}
- (void)sayhahahaToAmy {
    NSLog(@"hahaha Amy");
}
//- (void)setNumber:(NSString *)number {
//
//}
//- (NSString *)number {
//    return @"1212";
//}
//+ (BOOL)accessInstanceVariablesDirectly {
//
//    return YES;
//}

//- (void)log1 {
//    NSLog(@"log1");
//}
//- (void)log2 {
//    NSLog(@"log2");
//}
@end
