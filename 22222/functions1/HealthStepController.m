//
//  HealthStepController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/10/10.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "HealthStepController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <CoreMotion/CoreMotion.h>
#import <HealthKit/HealthKit.h>

@interface HealthStepController ()

@property (nonatomic, strong) HKHealthStore *healthStore;

@property(nonatomic, strong) UILabel *nameLabel;

@end

@implementation HealthStepController
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
    _healthStore = [[HKHealthStore alloc] init];
    if (![HKHealthStore isHealthDataAvailable]) {
        self.nameLabel.text = @"该设备不支持HealthKit";
        
    }        //创建healthStore对象
    self.healthStore = [[HKHealthStore alloc]init];
    //设置需要获取的权限 这里仅设置了步数
    HKObjectType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSet *healthSet = [NSSet setWithObjects:stepType,nil];
    //从健康应用中获取权限
    [self.healthStore requestAuthorizationToShareTypes:nil readTypes:healthSet completion:^(BOOL success, NSError * _Nullable error) {
        
        if (success) {
            //获取步数后我们调用获取步数的方法
            HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
            //NSSortDescriptor来告诉healthStore怎么样将结果排序
            NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
            NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
            //获取当前时间
            NSDate *now = [NSDate date];
            NSCalendar *calender = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *dateComponent = [calender components:unitFlags fromDate:now];
            int hour = (int)[dateComponent hour];
            int minute = (int)[dateComponent minute];
            int second = (int)[dateComponent second];
            NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) ];
            //时间结果与想象中不同是因为它显示的是0区
            NSLog(@"今天%@",nowDay);
            NSDate *nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400];
            NSLog(@"明天%@",nextDay);
            NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
            
            /*查询的基类是HKQuery，这是一个抽象类，能够实现每一种查询目标，这里我们需要查询的步数是一个HKSample类所以对应的查询类是HKSampleQuery。下面的limit参数传1表示查询最近一条数据，查询多条数据只要设置limit的参数值就可以了*/
            
            HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]initWithSampleType:sampleType predicate:predicate limit:0 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
                //设置一个int型变量来作为步数统计
                int allStepCount = 0;
                for (int i = 0; i < results.count; i ++) {
                    //把结果转换为字符串类型
                    HKQuantitySample *result = results[i];
                    HKQuantity *quantity = result.quantity;
                    NSMutableString *stepCount = (NSMutableString *)quantity;
                    NSString *stepStr =[ NSString stringWithFormat:@"%@",stepCount];
                    //获取51 count此类字符串前面的数字
                    NSString *str = [stepStr componentsSeparatedByString:@" "][0];
                    int stepNum = [str intValue];
                    NSLog(@"--------------------------%d",stepNum);
                    //把一天中所有时间段中的步数加到一起
                    allStepCount = allStepCount + stepNum;
                }
                
                //查询要放在多线程中进行，如果要对UI进行刷新，要回到主线程
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    self.nameLabel.text = [NSString stringWithFormat:@"%d",allStepCount];
                }];
            }];
            //执行查询
            [self.healthStore executeQuery:sampleQuery];
        }        else        {
            self.nameLabel.text = @"获取步数权限失败";
            
        }    }];
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
