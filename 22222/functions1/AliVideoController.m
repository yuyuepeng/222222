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
#import "AliyunVodPlayerView.h"
@interface AliVideoController ()<AVPDelegate,AliyunVodPlayerViewDelegate>

@property(nonatomic, strong) AliyunVodPlayerView *playerView;

@end

@implementation AliVideoController
- (AliyunVodPlayerView *__nullable)playerView{
    if (!_playerView) {
        CGFloat width = 0;
        CGFloat height = 0;
        CGFloat topHeight = 0;
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (orientation == UIInterfaceOrientationPortrait ) {
            width = mainWidth;
            height = mainHeight * 9 / 16.0;
            topHeight = 20;
        }else{
            width = mainWidth;
            height = mainHeight;
            topHeight = 20;
        }
        /****************UI播放器集成内容**********************/
        _playerView = [[AliyunVodPlayerView alloc] initWithFrame:CGRectMake(0,topHeight, width, height) andSkin:AliyunVodPlayerViewSkinRed];
//        _playerView.currentModel = _currentPlayVideoModel;
//        _playerView.circlePlay = YES;
        [_playerView setDelegate:self];
       // [_playerView setAutoPlay:YES];
        
        [_playerView setPrintLog:YES];
        
        _playerView.isScreenLocked = false;
        _playerView.fixedPortrait = false;
//        self.isLock = self.playerView.isScreenLocked||self.playerView.fixedPortrait?YES:NO;
    
    }
    return _playerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.playerView];
    [self.playerView playViewPrepareWithLocalURL:[NSURL URLWithString:@"http://player.alicdn.com/video/aliyunmedia.mp4"]];
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
