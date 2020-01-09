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
}

- (void)startWithDataSource:(NSMutableArray *)dataSource {
    dataSource = dataSource;
    if (dataSource.count < 3) {
        [self indirectlyStart];
        return;
    }
    
    [self startWithDataSource:dataSource];
}
- (void)indirectlyStart {
    
}
@end
