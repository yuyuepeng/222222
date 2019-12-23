//
//  wodexiaobaobei.m
//  22222
//
//  Created by 玉岳鹏 on 2019/2/20.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "wodexiaobaobei.h"
static wodexiaobaobei *wode;
@interface wodexiaobaobei ()

@end

@implementation wodexiaobaobei
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wode = [super allocWithZone:zone];
    });
    return wode;
}
+ (instancetype)shareObj {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wode = [[self alloc] init];
    });
    return wode;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (id)mutableCopy {
    return wode;
}
- (id)copy {
    return wode;
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
