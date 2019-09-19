//
//  aboutBlockVC.m
//  22222
//
//  Created by 玉岳鹏 on 2019/9/12.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "aboutBlockVC.h"

typedef void(^newname)(void);

@interface aboutBlockVC ()

@property(nonatomic, copy) newname block;


@end
static NSInteger nnn3 = 300;
NSInteger nnn4 = 3000;
@implementation aboutBlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //1、不使用外部变量的block是全局block
    NSLog(@"%@",[ ^{
        NSLog(@"globalBlock");
    } class]);
    //2、使用外部变量并且未进行copy操作的block是栈block
    NSInteger num = 10;
    NSLog(@"%@",[^{
        NSLog(@"stackBlock:%zd",num);
    } class]);
    [self testWithBlock:^{
        NSLog(@"self = %@",self);
    }];
    
    //3、对栈block进行copy操作，就是堆block，而对全局block进行copy，仍是全局block
    //比如堆1中的全局进行copy操作，即赋值：输出__NSGlobalBlock__ 仍是全局block
    void (^globalBlock)(void) = ^{
        NSLog(@"globalBlock");
    };
    NSLog(@"%@",[globalBlock class]);
    //而对2中的栈block进行赋值操作：输出L:__NSMallocBlock__
    NSInteger num2 = 10;
    void (^mallocBlock)(void) = ^{
        NSLog(@"stackBlock:%zd",num2);
    };
    NSLog(@"%@",[mallocBlock class]);
    //对栈blockcopy之后，并不代表着栈block就消失了，左边的mallock是堆block，右边被copy的仍是栈block
    [self testWithBlock11:^{
        NSLog(@"%@",self);
    }];
    //即如果对栈Block进行copy，将会copy到堆区，对堆Block进行copy，将会增加引用计数，对全局Block进行copy，因为是已经初始化的，所以什么也不做。
    
    
    
#pragma mark -- Block变量截获
//    1、局部变量截获 是值截获。 比如:
    NSInteger num22 = 3;
    NSInteger (^block)(NSInteger) = ^NSInteger (NSInteger n) {
        return n * num22;
    };
    num22 = 1;
    NSLog(@"局部变量%zd",block(2));
//    这里的输出是6而不是2，原因就是对局部变量num的截获是值截获。同样，在block里如果修改变量num，也是无效的，甚至编译器会报错。
    
    
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
    
    void(^block1)(void) = ^{
        
        NSLog(@"%@",arr);//局部变量
        
        [arr addObject:@"4"];
    };
    
    [arr addObject:@"3"];
    
    arr = nil;
    
    block1();
//    打印为1，2，3
//    局部对象变量也是一样，截获的是值，而不是指针，在外部将其置为nil，对block没有影响，而该对象调用方法会影响
    
    
//    2、局部静态变量截获 是指针截获。
    static  NSInteger num4 = 3;
    
    NSInteger(^block4)(NSInteger) = ^NSInteger(NSInteger n){
        
        return n*num4;
    };
    
    num = 1;
    
    NSLog(@"%zd",block4(2));
//    输出为2，意味着num = 1这里的修改num值是有效的，即是指针截获。
//    同样，在block里去修改变量m，也是有效的。
    
//    3、全局变量，静态全局变量截获：不截获,直接取值。
    
    NSInteger nnn = 30;
    
    static NSInteger nnn2 = 3;
    
    __block NSInteger nnn5 = 30000;
    
    void(^wodeblock)(void) = ^{
        
        NSLog(@"1-%zd",nnn);//局部变量
        
        NSLog(@"2-%zd",nnn2);//静态变量
        
        NSLog(@"3-%zd",nnn3);//全局变量
        
        NSLog(@"4-%zd",nnn4);//全局静态变量
        
        NSLog(@"5-%zd",nnn5);//__block修饰变量
    };
    
    wodeblock();
    
    
    // Do any additional setup after loading the view.
}
- (void)testWithBlock11:(dispatch_block_t)block {
    block();
    dispatch_block_t tempBlock = block;
    
    NSLog(@"%@,%@",[tempBlock class],[block class]);
    
}
- (void)testWithBlock:(dispatch_block_t)block {
    block();
    NSLog(@"%@", [block class]);
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
