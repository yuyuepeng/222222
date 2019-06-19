//
//  ChangeStrController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/10/10.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "ChangeStrController.h"

@interface ChangeStrController ()

@end

@implementation ChangeStrController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"wwww = %@",[self changeTenThousand:@"10000"]);
    NSLog(@"wwww = %@",[self changeTenThousand:@"10001"]);
    NSLog(@"wwww = %@",[self changeTenThousand:@"10010"]);
    NSLog(@"wwww = %@",[self changeTenThousand:@"10100"]);
    NSLog(@"wwww = %@",[self changeTenThousand:@"11000"]);
    NSLog(@"wwww = %@",[self changeTenThousand:@"1000000"]);
    NSLog(@"wwww = %@",[self changeTenThousand:@"12345"]);

    // Do any additional setup after loading the view.
}
- (NSString *)changeTenThousand:(NSString *)string {
    NSInteger num = [string integerValue];
    if (num >= 10000) {
        double doubleNum = num/10000.0000;
        string = [NSString stringWithFormat:@"%lf",doubleNum];
        //        NSInteger length = string.length;
        NSArray <NSString *>*arr1 = [string componentsSeparatedByString:@"."];
        NSString *lastObj;
        if (arr1.count > 1) {
            lastObj = [NSString stringWithFormat:@".%@",arr1[1]];
            NSInteger length1 = lastObj.length;
            for (NSInteger i = 0; i < length1; i ++) {
                if ([lastObj hasSuffix:@"0"]||[lastObj hasSuffix:@"."]) {
                    lastObj = [lastObj substringWithRange:NSMakeRange(0, lastObj.length - 1)];
                }
            }
            
            string = [NSString stringWithFormat:@"%@%@",arr1[0],lastObj];
        }else {
            
        }
    }
    return string;
}
- (NSString *)changeWan:(NSString *)str {
    NSInteger num = [str integerValue];
    if (num >= 10000) {
        double doubleNum = num/10000.0;
        str = [NSString stringWithFormat:@"%lf",doubleNum];
        NSInteger length = str.length;
        for (NSInteger i = 0; i < length; i ++) {
            if ([str hasSuffix:@"0"]||[str hasSuffix:@"."]) {
                str = [str substringWithRange:NSMakeRange(0, str.length - 1)];
            }
        }
        str = [NSString stringWithFormat:@"%@万",str];
    }
    return str;
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
