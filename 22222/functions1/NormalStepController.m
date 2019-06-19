//
//  NormalStepController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/10/10.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "NormalStepController.h"
#import <CoreMotion/CoreMotion.h>

@interface NormalStepController ()

@property (nonatomic, strong) CMPedometer *pedometer;//P
@property(nonatomic, strong) UILabel *nameLabel;

@end

@implementation NormalStepController
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, mainWidth, 400)];
        _nameLabel.numberOfLines = 0;
        _nameLabel.font =  [UIFont systemFontOfSize:12];
        _nameLabel.backgroundColor = [UIColor lightGrayColor];
    }
    return _nameLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.nameLabel];
    _pedometer = [[CMPedometer alloc]init];
    
    //判断记步功能
    
    if ([CMPedometer isStepCountingAvailable]) {
        
        [_pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            
            //
            
            if (error) {
                
                NSLog(@"error = %@",error);
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.nameLabel.text = [NSString stringWithFormat:@"您今天走了%@步\n,共计%@米,爬了%@楼,下了%@楼",pedometerData.numberOfSteps,pedometerData.distance,pedometerData.floorsAscended,pedometerData.floorsDescended];
                });
                NSLog(@"%@",pedometerData);
                
            }
            
        }];
        
    }else{
        NSLog(@"记步功能不可用");
    }

    // Do any additional setup after loading the view.
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
