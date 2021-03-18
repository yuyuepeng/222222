
//
//  YYPScrollViewController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/10/10.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "YYPScrollViewController.h"
#import "YYPScrollView.h"

@interface YYPScrollViewController ()

@property(nonatomic,strong) NSTimer *timer1;

@property(nonatomic,strong) NSTimer *timer2;

@end

@implementation YYPScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YYPScrollView *scrollView = [[YYPScrollView alloc] initWithFrame:CGRectMake(0, 100, mainWidth, 200)];
    NSArray *imageArray = [NSArray arrayWithObjects:@"img1.jpg",@"img2.jpg",@"img3.jpg",@"img4.jpg",@"img5.jpg",@"img6.jpg",@"img7.jpg",@"img8.jpg",@"img9.jpg",@"img10.jpg", nil];
    scrollView.imageSize = CGSizeMake(200, 200);
    scrollView.separatorWidth = 15;
    scrollView.userInteractionEnabled = false;
    [scrollView customImageViewWithImageUrls:imageArray];
    
    [self.view addSubview:scrollView];
    
    YYPScrollView *scrollView1 = [[YYPScrollView alloc] initWithFrame:CGRectMake(0, 400, mainWidth, 100)];
    scrollView1.imageSize = CGSizeMake(100, 100);
    scrollView1.separatorWidth = 15;
    [scrollView1 customImageViewWithImageUrls:imageArray];
    [self.view addSubview:scrollView1];
    
    scrollView.frame = CGRectMake(0, 100, mainWidth, 100);
    NSLog(@"232323232323");
    WeakSelf
//    self.timer1 = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"%@--- 123",weakSelf);
//    }];
//    self.timer1 = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nnnn) userInfo:nil repeats:YES];
//
//    [[NSRunLoop mainRunLoop] addTimer:self.timer1 forMode:NSRunLoopCommonModes];
//    self.timer2 = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"%@--- 456",weakSelf);
//    }];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer2 forMode:NSRunLoopCommonModes];

    // Do any additional setup after loading the view.
}
- (void)nnnn {
    NSLog(@"%@--- 123",self);

}
- (void)dealloc {
//    [self.timer1 invalidate];
//    [self.timer2 invalidate];
//    self.timer1 = nil;
//    self.timer2 = nil;
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
