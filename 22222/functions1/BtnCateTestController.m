//
//  BtnCateTestController.m
//  22222
//
//  Created by 扶摇先生 on 2019/6/21.
//  Copyright © 2019年 玉岳鹏. All rights reserved.
//

#import "BtnCateTestController.h"
#import "UIButton+YYPExtension.h"
static NSArray * ClassMethodNames(Class c) {
    NSMutableArray *array = [NSMutableArray array];
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(c, &methodCount);
    unsigned int i ;
    for ( i = 0; i < methodCount; i ++) {
        [array addObject:NSStringFromSelector(method_getName(methodList[i]))];
    }
    free(methodList);
    return array;
}
static NSArray * ClassPropertyNames(Class c) {
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(c, &propertyCount);
    //arrayWithCapacity的效率稍微高那么一丢丢
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:propertyCount];
    
    for (int i = 0; i < propertyCount ; i++)
    {
        //此刻得到的propertyName为c语言的字符串
        const char* propertyName =property_getName(propertyList[i]);
        //此步骤把c语言的字符串转换为OC的NSString
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }

    
    free(propertyList);
    return propertiesArray;
}
@interface BtnCateTestController ()

@end

@implementation BtnCateTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, mainWidth - 40, 100)];
    button.backgroundColor = [UIColor lightGrayColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor redColor] state:UIControlStateSelected];
    [button setBackgroundColor:[UIColor orangeColor] state:UIControlStateNormal];
    [button setUserInteractionDisabledBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:button];
//    NSLog(@"ClassMethodNames = %@",ClassMethodNames(object_getClass(button)));
//    NSLog(@"ClassMethodNames = %@",ClassPropertyNames(object_getClass(button)));
    NSLog(@"buttonState = %@",[button valueForKey:@"state"]);
    [button addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    // Do any additional setup after loading the view.
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"enabled"]) {
        NSLog(@"%@",change);
    }
}
- (void)buttonClick:(UIButton *)button {
    button.userInteractionEnabled = NO;
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
