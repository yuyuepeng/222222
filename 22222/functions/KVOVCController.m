//
//  KVOVCController.m
//  22222
//
//  Created by 玉岳鹏 on 2019/6/10.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "KVOVCController.h"
#import "Person.h"
@interface KVOVCController ()

@end

@implementation KVOVCController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *person = [[Person alloc] init];
    [person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    person.name = @"name";
    
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
