//
//  JianBianCirleController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/10/17.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "JianBianCirleController.h"
#import "WLArcChart.h"
#import "HXFPhoneNumView.h"

@interface JianBianCirleController ()

@end

@implementation JianBianCirleController

- (void)viewDidLoad {
    [super viewDidLoad];
//    WLArcChart *chart = [[WLArcChart alloc] initWithFrame:CGRectMake(0, 100, 200, 200) duration:2 showBgCyclic:YES percent:0.75];
//    [self.view addSubview:chart];
    
    HXFPhoneNumView *view = [[HXFPhoneNumView alloc] initWithFrame:CGRectMake(0, 100, mainWidth, mainWidth/ 750.0f * 135)];
    [self.view addSubview:view];
    
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
