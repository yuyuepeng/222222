//
//  PlayVideoController.m
//  22222
//
//  Created by 扶摇先生 on 2019/12/11.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "PlayVideoController.h"
#import "RYPlayerManager.h"

@interface PlayVideoController ()

@end

@implementation PlayVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[RYPlayerManager sharePlayerManager] playVideoWithUrl:@"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4"];

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
