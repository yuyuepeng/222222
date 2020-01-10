//
//  RMYCacheHelper.m
//  22222
//
//  Created by 王国良 on 2020/1/9.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import "RMYCacheHelper.h"

@implementation RMYCacheHelper {
    NSMutableArray *dataSource;
    NSInteger num;
}

- (void)startWithDataSource:(NSMutableArray *)dataSource {
//    NSArray *arr1 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
//    NSMutableArray *data = [NSMutableArray arrayWithArray:arr1];
//    NSMutableArray *source = [NSMutableArray array];
//    if (data.count > 3) {
//        [source addObjectsFromArray:[data subarrayWithRange:NSMakeRange(0, 3)]];
//        [data removeObjectsInRange:NSMakeRange(0, 3)];
//        NSLog(@"%@--",data);
//        NSLog(@"%@ ---",source);
//        for (NSInteger i = 0; i < 7 ; i ++) {
//            [source addObject:data[0]];
//            [data removeObjectAtIndex:0];
//            NSLog(@"%@---",data);
//            NSLog(@"%@ -----",source);
//        }
//    }else {
//        [source addObjectsFromArray:data];
//
//    }
    dataSource = dataSource;
    if (dataSource.count > 3) {
        
    }else {
        [self indirectlyStart];
        return;

    }


    for (NSInteger i = 0; i < 3; i ++) {

    }
    [self startWithDataSource:dataSource];
}
- (void)indirectlyStart {
    
}
@end
