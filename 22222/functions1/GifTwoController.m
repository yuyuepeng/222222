//
//  GifTwoController.m
//  22222
//
//  Created by 玉岳鹏 on 2019/1/23.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "GifTwoController.h"
#import "GifController1.h"
#import "GIFController.h"

@interface GifTwoController ()

@end

@implementation GifTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = @[@"GIFImageView",@"GIFWebView"];
    for (NSInteger i = 0; i < arr.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40 + i * 140 , 140 , 120, 40)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10 + i;
        [self.view addSubview:button];
    }
    // Do any additional setup after loading the view.
}
- (void)buttonClick:(UIButton *)button {
    if (button.tag == 10) {
        GifController1 *vc = [[GifController1 alloc] init];
//        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:vc animated:YES completion:nil];

        [(UINavigationController *)[UIApplication sharedApplication].delegate.window.rootViewController pushViewController:vc animated:YES];
    }else {
        GIFController *vc = [[GIFController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

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
