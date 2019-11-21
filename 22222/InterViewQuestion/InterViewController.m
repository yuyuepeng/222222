//
//  InterViewController.m
//  22222
//
//  Created by 玉岳鹏 on 2019/9/19.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "InterViewController.h"

#import "UIButton+extension.h"

@interface InterViewController ()

@property(nonatomic, copy) NSString *brand;



@end

@implementation InterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testPointerView) name:@"wodexiaobaobao" object:nil];
    self.brand = @"wqeqweq";
//    self.hhView
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    
    [button addTarget:self action:@selector(mamade) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setClickAreaWithTop:50.0f left:50.0f bottom:50.0f right:50.0f];
//    [self.view addSubview:button];
     AmyView *view = [[AmyView alloc] initWithFrame:CGRectMake(80, 100, 100, 100)];
    view.backgroundColor = [UIColor blueColor];
    view.tag = 101;
    self.hhView = view;
    [self.view addSubview:view];
    
    UIView *nnn = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    nnn.backgroundColor = [UIColor whiteColor];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mamade)]];
    [view addSubview:nnn];
//    [view removeFromSuperview];
    NSLog(@"%p,%p",self.hhView,view);
//    for (NSInteger i = 0; i < 10; i ++) {
//        [self somethingRelease];
//    }
    
    
    NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:[NSMutableArray arrayWithObject:@(3)],[NSMutableArray arrayWithObject:@(2)],nil];
    NSMutableArray *arr2 = [arr1 mutableCopy];
    NSLog(@"%@,%@",arr1,arr2);
    NSLog(@"%p,%p",arr1,arr2);
    NSLog(@"%p,%p",arr1[0],arr2[0]);
    for (NSInteger i = 0; i < arr1.count; i ++) {
        NSMutableArray *arr3 = [arr1[i] copy];
        [arr2 replaceObjectAtIndex:i withObject:arr3];
    }
    NSLog(@"%@,%@",arr1,arr2);
    NSLog(@"%p,%p",arr1,arr2);
    NSLog(@"%p,%p",arr1[0],arr2[0]);
    
    // Do any additional setup after loading the view.
}

- (void)mamade {
    NSLog(@"%@---",NSStringFromSelector(_cmd));
}
- (void)testPointerView {
    AmyView *view = (AmyView *)[self.view viewWithTag:101];
    NSLog(@"%p,%p",self.hhView,view);

}
- (void)somethingRelease {
   
}
//在 MRC 下如何重写属性的 Setter 和 Getter? setter

//-(void)setBrand:(NSString *)brand{
//    //如果实例变量指向的地址和参数指向的地址不同
//    if (_brand != brand)
//    {
//        //将实例变量的引用计数减一
//        [_brand release];
//        //将参数变量的引用计数加一,并赋值给实例变量
//        _brand = [brand retain];
//    }
//}
//getter
//-(NSString *)brand{
//    //将实例变量的引用计数加1后,添加自动减1
//    //作用,保证调用getter方法取值时可以取到值的同时在完全不需要使用后释放
//    return [[_brand retain] autorelease];
//}
//MRC下 手动释放内存 可重写dealloc但不要调用dealloc  会崩溃

//重写dealloc
//-(void)dealloc{
//    [_string release];
//    //必须最后调用super dealloc
//    [super  dealloc];
//}
- (void)dealloc {
//    NSLog(@"intVCHHView的内存%p",_hhView);
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
