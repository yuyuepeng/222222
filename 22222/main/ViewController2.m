//
//  ViewController2.m
//  22222
//
//  Created by 玉岳鹏 on 2018/9/21.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController.h"
@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"我的class = %@, nav = %@",NSStringFromClass(self.class),self.navigationController.viewControllers);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
    
    button.backgroundColor = [UIColor redColor];
    
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}
- (void)click:(UIButton *)btn {
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
    
    
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
