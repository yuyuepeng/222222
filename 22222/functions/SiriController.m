//
//  SiriController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/12/25.
//  Copyright © 2018 玉岳鹏. All rights reserved.
//

#import "SiriController.h"
#import <Speech/Speech.h>

@interface SiriController ()
@property(nonatomic, strong) AVAudioEngine *audioEngine;
@property(nonatomic, strong) SFSpeechRecognizer *speechRecognizer;
@property(nonatomic, strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;

@property(nonatomic, strong) UILabel *textView;

@end

@implementation SiriController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"SiriTest";
   
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        NSLog(@"status %@", status == SFSpeechRecognizerAuthorizationStatusAuthorized ? @"授权成功" : @"授权失败");
    }];
    
    UIButton *_addSiriBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 151, 200, 50)];
    self.textView = [[UILabel alloc] initWithFrame:CGRectMake(10, 252, mainWidth - 20, mainHeight - 252)];
    self.textView.numberOfLines = 0;
    self.textView.font = [UIFont systemFontOfSize:13];
    self.textView.textColor = [UIColor purpleColor];
    [_addSiriBtn setTitle:@"Siri识别" forState:UIControlStateNormal];
    [_addSiriBtn setTitle:@"Siri识别中" forState:UIControlStateSelected];

    [_addSiriBtn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    [_addSiriBtn addTarget:self action:@selector(beginShiBie:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:_addSiriBtn];
    [self.view addSubview:self.textView];

    // Do any additional setup after loading the view.
}
- (void)beginShiBie:(UIButton *)button {
    [self initEngine];
    button.selected = button.selected ? NO : YES;
    if (button.selected) {
        AVAudioFormat *recordingFormat = [[self.audioEngine inputNode] outputFormatForBus:0];
        [[self.audioEngine inputNode] installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
            [self.recognitionRequest appendAudioPCMBuffer:buffer];
        }];
        [self.audioEngine prepare];
        [self.audioEngine startAndReturnError:nil];
        [self.speechRecognizer recognitionTaskWithRequest:self.recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
            NSLog(@"is final: %d  result: %@", result.isFinal, result.bestTranscription.formattedString);
            //        if (result.isFinal) {
            self.textView.text = [NSString stringWithFormat:@"%@",  result.bestTranscription.formattedString];
            //        }
        }];
    }else {
        [[self.audioEngine inputNode] removeTapOnBus:0];
        [self.audioEngine stop];
        
        [self.recognitionRequest endAudio];
        self.recognitionRequest = nil;
    }
    
   
    
    
}
- (void)initEngine {
    if (!self.speechRecognizer) {
        // 设置语言
        NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
        self.speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:locale];
    }
    if (!self.audioEngine) {
        self.audioEngine = [[AVAudioEngine alloc] init];
    }
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryRecord mode:AVAudioSessionModeMeasurement options:AVAudioSessionCategoryOptionDuckOthers error:nil];
    [audioSession setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
    
    if (self.recognitionRequest) {
        [self.recognitionRequest endAudio];
        self.recognitionRequest = nil;
    }
    self.recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc] init];
    self.recognitionRequest.shouldReportPartialResults = YES;
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
