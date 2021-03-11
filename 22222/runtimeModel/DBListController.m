//
//  DBListController.m
//  22222
//
//  Created by 王国良 on 2020/1/8.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import "DBListController.h"
#import "RMYVideoModel.h"
#import "RMYVideoDownLoadCell.h"
#import <AliyunMediaDownloader/AliyunMediaDownloader.h>
#import <MJExtension/MJExtension.h>
@interface DBListController ()<UITableViewDelegate,AMDDelegate,UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray <RMYVideoModel *>*dataSource;

@property(nonatomic, strong) UITableView *tableView;


@end

@implementation DBListController
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, mainWidth, mainHeight - Height_NavBar) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 44;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray arrayWithArray:[RMYVideoModel findAll]];

//    for (RMYVideoModel *model in _dataSource) {
//        NSLog(@"%@ --- ",model.sandBoxPath);
//    }
    [self.view addSubview:self.tableView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(mainWidth - 64, 100, 44, 44)];
    [button setTitle:@"下载3个" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

- (void)buttonClick:(UIButton *)button {

    AVPVidStsSource *source = [[AVPVidStsSource alloc]init];//WithVid:@"9b2e0a6f142a4308ab96f9dad0b76eb9" accessKeyId:@"STS.NTuDm3yHzTVAK49gmHiPT1zx4" accessKeySecret:@"6KXiKJGDuZRTTw97FyEB8bA7KBxgfJu7LaBU359jZ8jC" securityToken:@"CAISiwJ1q6Ft5B2yfSjIr5fAD9eHlJdb45SqSRKIg20dZd943r/T1jz2IHlKdHBuCeoWs/QylWxU5voblrRtTtpfTEmBbI5t4MpVqhrwPtHTspGu/OEchIG5FDApu+gFTYqADd/iRfbxJ92PCTmd5AIRrJL+cTK9JS/HVbSClZ9gaPkOQwC8dkAoLdxKJwxk2qR4XDmrQpTLCBPxhXfKB0dFoxd1jXgFiZ6y2cqB8BHT/jaYo603392oesP9M5UxZ8wjCYnujLJMG/CfgHIK2X9j77xriaFIwzDDs+yGDkNZixf8aLOKooQxfFUpO/hnSvIY/KSlj5pxvu3NnMH7xhNKePtSVynP9kh1DXtxrYkagAEJc0p7YBNKaB3fQo+3YfShnUHSxH00uR/8MBuM2sAtyuZwskR6DrKjCKz4hSkxJ+VVlT9VMeZNg3f7CFffIBNTPQSO5N23393p2BvrUr6AWBDgtmV7BaAa69YCF57huXEVlP07SOrAe3opfvCo2AN0Nfn6y1veEAyA3fWCOVb1eg==" region:@"cn-shanghai"];
    AliMediaDownloader *downloader = [[AliMediaDownloader alloc] init];
    [downloader setSaveDirectory:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject];
    [downloader setDelegate:self];
    source.vid = @"1a5aafa7262c4367b2d79a31194e9a35";//视频vid
    source.region = @"cn-shanghai";//接入区域
    source.securityToken = @"CAISiwJ1q6Ft5B2yfSjIr5fiLu/it41y8qWKNRTb12UWfeVgpIbAqTz2IHlKdHBuCeoWs/QylWxU5voblrRtTtpfTEmBbI5t4MpVqhrwPtHTspGu/OEchIG5FzAk3cMjTYqADd/iRfbxJ92PCTmd5AIRrJL+cTK9JS/HVbSClZ9gaPkOQwC8dkAoLdxKJwxk2qR4XDmrQpTLCBPxhXfKB0dFoxd1jXgFiZ6y2cqB8BHT/jaYo603392oesP9M5UxZ8wjCYnujLJMG/CfgHIK2X9j77xriaFIwzDDs+yGDkNZixf8aLOKooQxfFUpO/hnSvIY/KSlj5pxvu3NnMH7xhNKePtSVynP9kh1DXtxrYkagAFZMCgwsd7SplXuAutx6BjJHdghFubKsyu8YulAZKixkuCy8aNe6cM2Kat0YzNpYBBTn/Tle2F1PsPxovwh8HzLeQSlUum5t+QWtjFxj8nmmcbm1yjMIcRVIIrc8oIUzFK5xGVIl9DpV2aJkvc8kBB7WQNkzYRpvxzJzPp7W9qacA==";//安全token
    source.accessKeySecret = @"5r8oiSxaQqRXX5HbFDjmWjSphooEaZWLBxSMCf3os1SM";//临时akSecret
    source.accessKeyId = @"STS.NTWeUVZRSEga72j3eCqjLKCkK";//临时akId
    [downloader prepareWithVid:source];

//    [downloader start];
    
}
- (void)onDownloadingProgress:(AliMediaDownloader*)downloader percentage:(int)percent {
    NSLog(@"我的downloadProgress = %d",percent);
}
- (void)onError:(AliMediaDownloader *)downloader errorModel:(AVPErrorModel *)errorModel {
    NSDictionary *dict = [errorModel mj_keyValues];
    NSLog(@"我的错误 dict = %@",dict);
}
- (void)onCompletion:(AliMediaDownloader *)downloader {
    
}
-(void)onPrepared:(AliMediaDownloader*)downloader mediaInfo:(AVPMediaInfo*)info {
    
    NSDictionary *dict = [info mj_keyValues];
    NSLog(@"将要完成的 dict = %@",dict);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RMYVideoDownLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RMYVideoDownLoadCellID"];
    if (cell == nil) {
        cell = [[RMYVideoDownLoadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RMYVideoDownLoadCellID"];
    }
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
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
