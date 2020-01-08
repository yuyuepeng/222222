//
//  FMDBController.m
//  22222
//
//  Created by 王国良 on 2020/1/8.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import "FMDBController.h"
#import <CommonCrypto/CommonDigest.h>
#import "DBListController.h"
#import "RMYVideoModel.h"
static NSString *YHRequestDownloadMd5String(NSString *key) {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    return filename;
}

@interface FMDBController ()

@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UIButton *button1;

@end

@implementation FMDBController

- (void)viewDidLoad {
    [super viewDidLoad];
    _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, mainWidth, 50)];
    [_button setTitle:@"插入10条video" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_button];
    
    _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, mainWidth, 50)];
    [_button1 setTitle:@"查询" forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
    [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:_button1];
    // Do any additional setup after loading the view.
}

- (void)buttonClick {
    for (NSInteger i = 0;  i < 10; i ++) {
        RMYVideoModel *model = [[RMYVideoModel alloc] init];
        model.vid = [NSString stringWithFormat:@"%ld",i];
        model.pk = [model.vid intValue];
        NSString *sandBoxPath = [NSString stringWithFormat:@"video%ld",i];
        model.sandBoxPath = YHRequestDownloadMd5String(sandBoxPath);
    }
}
- (void)button1Click {
    DBListController *listVC = [[DBListController alloc] init];
    [self.navigationController pushViewController:listVC animated:YES];
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
