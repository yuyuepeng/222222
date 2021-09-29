//
//  Person+cate.m
//  22222
//
//  Created by 玉岳鹏 on 2019/8/28.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "Person+cate.h"

@implementation Person (cate)

+ (void)load {
    NSLog(@"我的小宝宝 Amy老师");
    static dispatch_once_t onceToken;
    Class class = object_getClass ((id) self);
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getClassMethod(class, @selector(sayHelloToAmy));
        Method newMethod = class_getClassMethod(class, @selector(sayILoveYouToAmy));
        BOOL success = class_addMethod(class, @selector(sayILoveYouToAmy), method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        // 如果方法存在，也会添加失败,为了防止子类重写方法
        if (success) {
            //用刚add的新方法replace旧方法
            class_replaceMethod(class, @selector(sayILoveYouToAmy), method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        }else {
            method_exchangeImplementations(originMethod, newMethod);
        }
        Class class1 = [self class];
        Method originSay = class_getInstanceMethod(class1, @selector(sayhahahaToAmy));
        Method likeSay = class_getInstanceMethod(class1, @selector(sayIlikeYouAmy));
        BOOL success1 = class_addMethod(class1, @selector(sayIlikeYouAmy), method_getImplementation(likeSay), method_getTypeEncoding(likeSay));
        if (success1) {
            class_replaceMethod(class1, @selector(sayIlikeYouAmy), method_getImplementation(originSay), method_getTypeEncoding(originSay));
        }else {
            method_exchangeImplementations(originSay, likeSay);
        }
    });
}

- (void)sayIlikeYouAmy {
    NSLog(@"I like you, Amy");
}
+ (void)sayILoveYouToAmy {
    NSLog(@"I love you, Amy");
}

@end
