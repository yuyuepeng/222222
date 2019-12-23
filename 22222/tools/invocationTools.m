//
//  invocationTools.m
//  22222
//
//  Created by 扶摇先生 on 2019/11/29.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "invocationTools.h"

@implementation invocationTools

+ (void)callMethodWithPara:(NSDictionary *)para target:(id)target selector:(SEL)selector {
    NSMethodSignature*signature = [[target class] instanceMethodSignatureForSelector:selector];
    //1、创建NSInvocation对象
    NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = target;
    //invocation中的方法必须和签名中的方法一致。
    invocation.selector = selector;
    /*第一个参数：需要给指定方法传递的值
           第一个参数需要接收一个指针，也就是传递值的时候需要传递地址*/
    //第二个参数：需要给指定方法的第几个参数传值
    //注意：设置参数的索引时不能从0开始，因为0已经被self占用，1已经被_cmd占用
    [invocation setArgument:&para atIndex:2];
    //2、调用NSInvocation对象的invoke方法
    //只要调用invocation的invoke方法，就代表需要执行NSInvocation对象中制定对象的指定方法，并且传递指定的参数
    [invocation invoke];
}

@end
