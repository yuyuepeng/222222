//
//  YYPBezierViewController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/10/10.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "YYPBezierViewController.h"
#import "YYPBezierView.h"

@interface YYPBezierViewController ()

@end

@implementation YYPBezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YYPBezierView *bezierView = [[YYPBezierView alloc] initWithFrame:CGRectMake(0, 100, mainWidth, 120) values:@[@"2.88",@"3.66",@"4.32",@"2.55",@"2.88",@"3.66",@"4.32",@"4.32",@"2.55",@"2.88",@"3.66",@"2.55",@"2.88",@"3.66",@"4.32",@"2.55",@"2.88",@"3.66",@"4.32",@"2.55",@"2.88",@"3.66",@"4.32",@"2.55"] leftItems:@[@"8",@"6",@"4"] bottomItems:@[@"一月",@"二月",@"三月",@"四月"]];
    [self.view addSubview:bezierView];

    // Do any additional setup after loading the view.
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
