//
//  XiushiciController.m
//  22222
//
//  Created by 玉岳鹏 on 2019/8/7.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "XiushiciController.h"

@interface father : NSObject

@end

@implementation father



@end

@interface son : father

@end

@implementation son

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"%@", NSStringFromClass([self class]));
        NSLog(@"%@", NSStringFromClass([super class]));
        BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
        BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
        father *dd = [[father alloc] init];
        BOOL res3 = [dd isKindOfClass:[father class]];
        BOOL res4 = [(id)[father class] isMemberOfClass:object_getClass((id)[father class])];
        NSLog(@"%d--%d--%d--%d", res1, res2, res3, res4);

//        NSStringFromClass([self class]) = Son
//        NSStringFromClass([super class]) = Son
//        详解：这个题目主要是考察关于 Objective-C 中对 self 和 super 的理解。
//        self 是类的隐藏参数，指向当前调用方法的这个类的实例；
//        super 本质是一个编译器标示符，和 self 是指向的同一个消息接受者。不同点在于：super 会告诉编译器，当调用方法时，去调用父类的方法，而不是本类中的方法。
//        当使用 self 调用方法时，会从当前类的方法列表中开始找，如果没有，就从父类中再找；而当使用 super 时，则从父类的方法列表中开始找。然后调用父类的这个方法。
//        在调用[super class]的时候，runtime会去调用objc_msgSendSuper方法，而不是objc_msgSend；

//由于找到了父类NSObject里面的class方法的IMP，又因为传入的入参objc_super->receiver = self。self就是son，调用class，所以父类的方法class执行IMP之后，输出还是son，最后输出两个都一样，都是输出son。        作者：全网iOS面试题总结
      
        
   
    }
    return self;
}

@end

@interface Personaaaaaa :NSObject


@end

@implementation Personaaaaaa



@end

@interface XiushiciController ()

@property(nonatomic, assign) NSMutableArray *arr;

@property(nonatomic, weak) NSMutableArray *arr1;

@property(nonatomic, strong) NSMutableArray *arr2;

@property(nonatomic, strong) NSMutableArray *arr3;

@property(nonatomic, copy) NSMutableArray *arr5;


@end

@implementation XiushiciController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.arr = [NSMutableArray array];
//    NSLog(@"%p----%@",_arr,_arr);
//      [self.arr addObject:@"2dsahdjakjs"]; //会崩溃，assign 不能修饰对象  ,会报野指针错误 因为assign修饰的对象引用计数不会加一  对象直接被销毁 但是指针不会指向nil，仍然指向销毁的的那个对象原来的地址，地址仍在只是对象没了;
    self.arr1 = [NSMutableArray array];
//    [self.arr1 addObject:@"wejwejwjewi"];  //不会崩溃  weak 只能修饰对象  修饰基本数据类型会报错,引用计数不会加一 但是因为对象销毁，并且指针指向nil，oc中特性对nil发送信息不会报错，
    self.arr2 = [NSMutableArray array];//[NSMutableArray array]创造了一个对象A，此时A的引用计数为1，self.arr2做为对象B，把A赋值给B的时候，A的引用计数加1，此时A的引用计数为2，B指向了A，然后编译器会自动对A进行释放操作(因为是局部变量)，A的引用计数-1。在拥有B的对象不释放的时候，A的引用计数永远不可能为0，除非你手动释放或者把B指向一个新的对象，这样A永远不会被释放，这就是所谓的强引用。但是B的引用计数是2
    NSString * string = [NSString stringWithFormat:@"1"];
    NSString * copyString = [string copy];
    NSString * mutableCopyString = [string mutableCopy];
    NSLog(@"string:%p", string);
    NSLog(@"copyString:%p", copyString);
    NSLog(@"mutableCopyString:%p", mutableCopyString);
    
    /*
    在说copy与mutableCopy之前我们先看看官方文档对深拷贝与浅拷贝的阐释，如下
    
    深拷贝：
    对象拷贝 - 重新申请一片内存保留这个对象，与原对象之间没有半点关系。
    浅拷贝：
    指针拷贝 - 实际上相当于引用计数+1，被拷贝的和拷贝的引用同一个对象。
    接下来我们分两个方面做测试：
    */
    Personaaaaaa *p = [[Personaaaaaa alloc] init];
    NSObject *aaa = [[NSObject alloc] init];
    
    NSMutableArray *arr4 = [NSMutableArray array]; //arr4引用计数为1；
    NSLog(@"retainCount4 -- %ld",CFGetRetainCount((__bridge CFTypeRef)(arr4)));

    self.arr3 = arr4;//引用计数为3, 实例化arr4 为1  引用一次+1   strong 强引用+1（因为指向的是同一个对象的内存，所以强引用计数都是一个对象的  相等，strong修饰的都是浅拷贝）；
    NSLog(@"retainCount3 -- %ld   retainCount4 -- %ld",CFGetRetainCount((__bridge CFTypeRef)(self.arr3)),CFGetRetainCount((__bridge CFTypeRef)(arr4)));
//    [arr4 addObject:@"2323232"];
    self.arr5 = arr4;//当copy 修饰且无元素时，两个的引用计数是-1  有元素时  如果arr4是可变数组 引用计数先+1 再-1  为1 copy 出来的对象  引用计数 +1之后不减 为2     如果arr4是不可变数组copy的作用和strong一样，属于浅拷贝指向同一对象的内存地址(copy修饰的对象 如果是可变对象  属于深拷贝，新开辟一段内存空间存储对象，如果修饰的不可变对象，属于浅拷贝，指向同一对象的内存地址和strong效果一样)
    [arr4 addObject:@"2"];
//    [不可变  copy]  == [不可变]  浅拷贝
//    [可变  copy]      == [不可变]  深拷贝  从对象类型上也能看出 可变到不可变
//
//
//    [不可变  mutableCopy]  == [可变]  深拷贝  从对象类型上也能看出 不可变到可变
//    [可变  mutableCopy]      == [可变]  深拷贝
    NSLog(@"%@,%@",self.arr3,arr4);

    // Do any additional setup after loading the view.
    
    son *s = [[son alloc] init];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
