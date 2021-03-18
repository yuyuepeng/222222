//
//  YYPTimer.h
//  22222
//
//  Created by 扶摇先生 on 2021/3/17.
//  Copyright © 2021 玉岳鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYPTimer : NSObject

+ (YYPTimer *)createTimerWithInterval:(NSUInteger)interval action:(void(^)(void))action repeat:(BOOL)repeat;

- (void)startTimerWithInterval:(NSUInteger)interval action:(void(^)(void))action repeat:(BOOL)repeat;
- (void)resumeTimer;
- (void)suspendTimer;

@end

NS_ASSUME_NONNULL_END
