//
//  KVOVCController.m
//  22222
//
//  Created by 玉岳鹏 on 2019/6/10.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "KVOVCController.h"
#import "Person.h"
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
@interface KVOVCController ()

@end

@implementation KVOVCController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *person = [[Person alloc] init];
    person.name = @"name";
    NSLog(@"person->isa:%@", object_getClass(person));
    NSLog(@"person class:%@", [person class]);
    NSLog(@"ClassMethodNames:%@", ClassMethodNames(object_getClass(person)));
    [person showObjectInfo];
    [person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    NSLog(@"person->isa:%@", object_getClass(person));
    NSLog(@"person class:%@", [person class]);
    NSLog(@"ClassMethodNames:%@", ClassMethodNames(object_getClass(person)));
    [person showObjectInfo];
    person.name = @"Jack";
    
    // 3. 移除KVO
    [person removeObserver:self forKeyPath:@"name"];
    [person removeObserver:self forKeyPath:@"age"];
    NSLog(@"person->isa:%@", object_getClass(person));
    NSLog(@"person class:%@", [person class]);
    NSLog(@"ClassMethodNames:%@", ClassMethodNames(object_getClass(person)));
    [person showObjectInfo];
    // Do any additional setup after loading the view.
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"changes == %@",change);
}
- (void)dealloc {
    
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
