//
//  iFlyController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/10/10.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "iFlyController.h"
#import "HXFAnimationTools.h"
#import <MessageUI/MessageUI.h>
#import "WLArcChart.h"
#import <iflyMSC/iflyMSC.h>
#import "ViewController2.h"
#import "IATConfig.h"
#import "IFlyContact.h"
#import "ISRDataHelper.h"
@interface iFlyController ()<MFMessageComposeViewControllerDelegate,IFlySpeechRecognizerDelegate,IFlyRecognizerViewDelegate,UIActionSheetDelegate,IFlyPcmRecorderDelegate>
@property(nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//Recognition conrol without view
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//Recognition control with view
@property (nonatomic, strong) IFlyDataUploader *uploader;//upload control
@property (nonatomic, strong) IFlyPcmRecorder *pcmRecorder;//P

@end

@implementation iFlyController
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, mainWidth, 400)];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font =  [UIFont systemFontOfSize:12];
        _nameLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _nameLabel;
}
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"我的class = %@, nav = %@",NSStringFromClass(self.class),self.navigationController.viewControllers);
    [self initRecognizer];
    
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            break;
        default:
            break;
    }
}
- (void)initRecognizer {
    
    if ([IATConfig sharedInstance].haveView == NO) {
        
        //recognition singleton without view
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        }
        
        [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //set recognition domain
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
        _iFlySpeechRecognizer.delegate = self;
        
        if (_iFlySpeechRecognizer != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            
            //set timeout of recording
            [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //set VAD timeout of end of speech(EOS)
            [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //set VAD timeout of beginning of speech(BOS)
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //set network timeout
            [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //set sample rate, 16K as a recommended option
            [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            //set language
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //set accent
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            
            //set whether or not to show punctuation in recognition results
            [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
        
        //Initialize recorder
        if (_pcmRecorder == nil)
        {
            _pcmRecorder = [IFlyPcmRecorder sharedInstance];
        }
        
        _pcmRecorder.delegate = self;
        
        [_pcmRecorder setSample:[IATConfig sharedInstance].sampleRate];
        
        [_pcmRecorder setSaveAudioPath:nil];    //not save the audio file
        
    }else  {
        
        //recognition singleton with view
        if (_iflyRecognizerView == nil) {
            
            _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
        }
        
        [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
        
        //set recognition domain
        [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        
        
        _iflyRecognizerView.delegate = self;
        
        if (_iflyRecognizerView != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            //set timeout of recording
            [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //set VAD timeout of end of speech(EOS)
            [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //set VAD timeout of beginning of speech(BOS)
            [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //set network timeout
            [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //set sample rate, 16K as a recommended option
            [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            //set language
            [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //set accent
            [_iflyRecognizerView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            //set whether or not to show punctuation in recognition results
            [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
    }
    
    //    if([[IATConfig sharedInstance].language isEqualToString:@"en_us"]){
    //        if([IATConfig sharedInstance].isTranslate){
    //            [self translation:NO];
    //        }
    //    }
    //    else{
    //        if([IATConfig sharedInstance].isTranslate){
    //            [self translation:YES];
    //        }
    //    }
    
    //音频写入结束或出错时，必须调用结束识别接口
    //    [self.iFlySpeechRecognizer stopListening];//音频数据写入完成
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"录制" forState:UIControlStateNormal];
    [button setTitle:@"录制中" forState:UIControlStateSelected];
    button.backgroundColor = [UIColor greenColor];
    [self.view addSubview:button];
    
    [self.view addSubview:self.nameLabel];
    
    // Do any additional setup after loading the view.
}
- (void)buttonClick:(UIButton *)button {
    
        button.selected = button.selected ? false : YES;
    
        if ([IATConfig sharedInstance].haveView == NO) {
    
    
            if(_iFlySpeechRecognizer == nil)
            {
                [self initRecognizer];
            }
    
            [_iFlySpeechRecognizer cancel];
    
            //Set microphone as audio source
            [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
            //Set result type
            [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
            //Set the audio name of saved recording file while is generated in the local storage path of SDK,by default in library/cache.
            [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
            [_iFlySpeechRecognizer setDelegate:self];
    
            BOOL ret = [_iFlySpeechRecognizer startListening];
    
            if (ret) {
    
    
            }else{
    
            }
        }else {
    
            if(_iflyRecognizerView == nil)
            {
                [self initRecognizer];
            }
    
    
            //Set microphone as audio source
            [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
            //Set result type
            [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
            //Set the audio name of saved recording file while is generated in the local storage path of SDK,by default in library/cache.
            [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
            BOOL ret = [_iflyRecognizerView start];
            if (ret) {
    
            }
        }
    
        if([[IATConfig sharedInstance].language isEqualToString:@"en_us"]){
            if([IATConfig sharedInstance].isTranslate){
                [self translation:NO];
            }
        }
        else{
            if([IATConfig sharedInstance].isTranslate){
                [self translation:YES];
            }
        }
    
    //    TestViewConteroller *vc = [[TestViewConteroller alloc] init];
    //
    //    vc.block1 = ^{
    //        ViewController2 *vc1 = [[ViewController2 alloc] init];
    //        [self.navigationController pushViewController:vc1 animated:YES];
    //    };
    //    [self.navigationController pushViewController:vc animated:YES];
    //    CABasicAnimation *animation = [HXFAnimationTools scale:@(1) orgin:@(2) durTimes:1.0f Rep:3];
    //    [button.layer addAnimation:animation forKey:@"2020220"];
    
        if (button.selected) {
            [self.iFlySpeechRecognizer startListening];
        }else {
            [self.iFlySpeechRecognizer stopListening];
        }
    
}
-(void)translation:(BOOL) langIsZh
{
    
    if ([IATConfig sharedInstance].haveView == NO) {
        [_iFlySpeechRecognizer setParameter:@"1" forKey:[IFlySpeechConstant ASR_SCH]];
        
        if(langIsZh){
            [_iFlySpeechRecognizer setParameter:@"cn" forKey:@"orilang"];
            [_iFlySpeechRecognizer setParameter:@"en" forKey:@"translang"];
        }
        else{
            [_iFlySpeechRecognizer setParameter:@"en" forKey:@"orilang"];
            [_iFlySpeechRecognizer setParameter:@"cn" forKey:@"translang"];
        }
        
        [_iFlySpeechRecognizer setParameter:@"translate" forKey:@"addcap"];
        
        [_iFlySpeechRecognizer setParameter:@"its" forKey:@"trssrc"];
    }
    else{
        [_iflyRecognizerView setParameter:@"1" forKey:[IFlySpeechConstant ASR_SCH]];
        
        if(langIsZh){
            [_iflyRecognizerView setParameter:@"cn" forKey:@"orilang"];
            [_iflyRecognizerView setParameter:@"en" forKey:@"translang"];
        }
        else{
            [_iflyRecognizerView setParameter:@"en" forKey:@"orilang"];
            [_iflyRecognizerView setParameter:@"cn" forKey:@"translang"];
        }
        
        [_iflyRecognizerView setParameter:@"translate" forKey:@"addcap"];
        
        [_iflyRecognizerView setParameter:@"its" forKey:@"trssrc"];
    }
    
}
- (void)onCompleted:(IFlySpeechError *)errorCode {
    NSLog(@"错误类型 == %@",errorCode.errorDesc);
}

- (void)onResults:(NSArray *)results isLast:(BOOL)isLast {
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    
    NSString * resultFromJson =  nil;
    
    if([IATConfig sharedInstance].isTranslate){
        
        NSDictionary *resultDic  = [NSJSONSerialization JSONObjectWithData:    //The result type must be utf8, otherwise an unknown error will happen.
                                    [resultString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
        if(resultDic != nil){
            NSDictionary *trans_result = [resultDic objectForKey:@"trans_result"];
            
            if([[IATConfig sharedInstance].language isEqualToString:@"en_us"]){
                NSString *dst = [trans_result objectForKey:@"dst"];
                NSLog(@"dst=%@",dst);
                resultFromJson = [NSString stringWithFormat:@"%@\ndst:%@",resultString,dst];
            }
            else{
                NSString *src = [trans_result objectForKey:@"src"];
                NSLog(@"src=%@",src);
                resultFromJson = [NSString stringWithFormat:@"%@\nsrc:%@",resultString,src];
            }
        }
    }
    else{
        resultFromJson = [ISRDataHelper stringFromJson:resultString];
    }
    if (self.nameLabel.text.length > 0) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@%@", self.nameLabel.text,resultFromJson];
    }else {
        self.nameLabel.text = [NSString stringWithFormat:@"%@",resultFromJson];
    }
    
    if (isLast){
        //        NSLog(@"ISR Results(json)：%@",  self.result);
    }
}

- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast {
    NSLog(@"2---%@",resultArray);
}

- (void)onIFlyRecorderBuffer:(const void *)buffer bufferSize:(int)size {
    
}

- (void)onIFlyRecorderError:(IFlyPcmRecorder *)recoder theError:(int)error {
    //NSLog(@"3---%@",recoder.)
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
