//
//  AliVideoController.m
//  22222
//
//  Created by 扶摇先生 on 2020/1/2.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import "AliVideoController.h"
#import <AliyunPlayer/AliyunPlayer.h>
#import <AliyunMediaDownloader/AliyunMediaDownloader.h>

@interface AliVideoController ()<AVPDelegate>

@end

@implementation AliVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    AliPlayer *player = [[AliPlayer alloc] init];
    player.autoPlay = YES;
//    AVPUrlSource *source = [[AVPUrlSource alloc] init];
   AVPVidStsSource *source = [[AVPVidStsSource alloc]initWithVid:@"9b2e0a6f142a4308ab96f9dad0b76eb9" accessKeyId:@"STS.NTLf1C15ha8TCZHnmsDFG7KxP" accessKeySecret:@"G6ZkQu5zk5iMrhDqvJbij1aEu36gVXsoYj7PXYfFwtz9" securityToken:@"CAISiwJ1q6Ft5B2yfSjIr5f5LYv33OpJ1vq/QXz5im0mSMlr2I7Tsjz2IHlKdHBuCeoWs/QylWxU5voblrRtTtpfTEmBbI5t4MpVqhrwPtHTspGu/OEchIG5FzBkmc0jQoqADd/iRfbxJ92PCTmd5AIRrJL+cTK9JS/HVbSClZ9gaPkOQwC8dkAoLdxKJwxk2qR4XDmrQpTLCBPxhXfKB0dFoxd1jXgFiZ6y2cqB8BHT/jaYo603392oesP9M5UxZ8wjCYnujLJMG/CfgHIK2X9j77xriaFIwzDDs+yGDkNZixf8aLOKooQxfFUpO/hnSvIY/KSlj5pxvu3NnMH7xhNKePtSVynP9kh1DXtxrYkagAEPipXhTCycTH0+QKCuoYJ3drEfogF6ROHCCnzmT4RwFSsJjQxgVW/5hn1gLi5d6dzqQHbC/WqJb5lfWr6PFdY6XTeSWqcFnOwWCtThUHzo0ay6Kg7jD4+78o9jQ4VjGrvhTBW5PAiSfsCLUmqxaspYAiYoHvtAN2q4eVj9GimlLA==" region:@"cn-shanghai"];
//    source.playerUrl = [NSURL URLWithString:@"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar, mainWidth, mainHeight - Height_NavBar)];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view];
    player.delegate = self;
    [player setUrlSource:nil];
    [player setStsSource:source];
    player.playerView = view;
    [player prepare];
    [player start];
    // Do any additional setup after loading the view.
}
- (void)onError:(AliPlayer*)player errorModel:(AVPErrorModel *)errorModel {
    NSLog(@"错误 -- %@",errorModel.message);
}
-(void)onPlayerEvent:(AliPlayer*)player eventType:(AVPEventType)eventType {
    switch (eventType) {
        case AVPEventPrepareDone: {
            // 准备完成
            NSLog(@"准备完成");
        }
            break;
        case AVPEventAutoPlayStart:
            // 自动播放开始事件
            NSLog(@"自动播放开始事件");

            break;
        case AVPEventFirstRenderedStart:
            // 首帧显示
            NSLog(@"首帧显示");
            break;
        case AVPEventCompletion:
            // 播放完成
            NSLog(@"播放完成");
            break;
        case AVPEventLoadingStart:
            // 缓冲开始
            NSLog(@"缓冲开始");
            break;
        case AVPEventLoadingEnd:
            // 缓冲完成
            NSLog(@"缓冲完成");
            break;
        case AVPEventSeekEnd:
            // 跳转完成
            NSLog(@"跳转完成");
            break;
        case AVPEventLoopingStart:
            // 循环播放开始
            NSLog(@"循环播放开始");
            break;
        default:
            break;
    }
}
-(void)onPlayerEvent:(AliPlayer*)player eventWithString:(AVPEventWithString)eventWithString description:(NSString *)description {
    NSLog(@"%@ -- description",description);
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
