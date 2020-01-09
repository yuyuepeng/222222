//
//  EUTransLationTools.m
//  22222
//
//  Created by 王国良 on 2020/1/9.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import "EUTransLationTools.h"

@implementation EUTransLationTools

+ (void)pushViewController:(UIViewController *)viewController params:(NSDictionary *)params {
    NSMethodSignature*signature = [[viewController class] instanceMethodSignatureForSelector:@selector(sendMessageWithNumber:WithContent:)];
          //1、创建NSInvocation对象
          NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
          invocation.target = self;
          //invocation中的方法必须和签名中的方法一致。
          invocation.selector = @selector(sendMessageWithNumber:WithContent:);
          /*第一个参数：需要给指定方法传递的值
                 第一个参数需要接收一个指针，也就是传递值的时候需要传递地址*/
          //第二个参数：需要给指定方法的第几个参数传值
          NSString*number = @"1111";
          //注意：设置参数的索引时不能从0开始，因为0已经被self占用，1已经被_cmd占用
          [invocation setArgument:&number atIndex:2];
          NSString*number2 = @"啊啊啊";
          [invocation setArgument:&number2 atIndex:3];
          //2、调用NSInvocation对象的invoke方法
          //只要调用invocation的invoke方法，就代表需要执行NSInvocation对象中制定对象的指定方法，并且传递指定的参数
    //      [invocation invoke];
//        [invocationTools callMethodWithPara:@{@"name":@"李梅",@"shuxiang":@"属猴",@"property":@"美女",@"birth":@"92年",@"aciton":@"堆雪人"} target:self selector:@selector(amysInfo:)];
}

@end
