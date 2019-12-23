//
//  RYPlayerManager.m
//  22222
//
//  Created by 扶摇先生 on 2019/12/11.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "RYPlayerManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
static RYPlayerManager *manager = nil;

@interface RYPlayerManager()

@property(nonatomic, strong) AVPlayer *player;

@property(nonatomic, strong) UIView *contentView;

@property(nonatomic, strong) UIButton *playButton;

@property(nonatomic, strong) UIButton *kuaijinBtn;

@property(nonatomic, strong) UIButton *kuaituiBtn;



@end

@implementation RYPlayerManager

+ (instancetype)sharePlayerManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}
- (id)copy {
    return manager;
}
- (id)mutableCopy {
    return manager;
}
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, mainWidth, 300)];
        _contentView.backgroundColor = [UIColor lightGrayColor];
    }
    return _contentView;
}
- (UIButton *)playButton {
    if (_playButton == nil) {
        _playButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, 80, 40)];
        [_playButton setTitle:@"播放" forState:UIControlStateNormal];
        [_playButton setTitle:@"暂停" forState:UIControlStateSelected];
        _playButton.backgroundColor = [UIColor orangeColor];
        [_playButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playButton;
}
- (void)playButtonClick:(UIButton *)playButton {
    playButton.selected = playButton.selected ? NO : YES;
    if (playButton.selected) {
        [self play];
    }else {
        [self stop];
    }
}
- (void)stop {
    [self.player pause];
}
- (void)play {
    [self.player play];
}
- (void)playVideoWithUrl:(NSString *)videoUrl {
    [self playVideoWithUrl:videoUrl contentView:[self customContentView]];
   
}
- (UIView *)customContentView {
    [self.contentView addSubview:self.playButton];
    return self.contentView;
}
- (void)playVideoWithUrl:(NSString *)videoUrl contentView:(UIView *)contentView {
    if (contentView == nil) {
        [self customContentView];
    }
    UIViewController *vc = [self getCurrentVC];
    [vc.view addSubview:contentView];
    AVPlayerItem *avplayerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:videoUrl]];
    self.player = [[AVPlayer alloc] initWithPlayerItem:avplayerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = contentView.bounds;
    [contentView.layer addSublayer:playerLayer];
    self.playButton.selected = YES;
    [self.player play];

}
- (UIViewController *)getCurrentVC {
    return [UIApplication sharedApplication].delegate.window.rootViewController.childViewControllers.lastObject;
}
@end
