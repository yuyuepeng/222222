//
//  YYPTimer.m
//  22222
//
//  Created by 扶摇先生 on 2021/3/17.
//  Copyright © 2021 玉岳鹏. All rights reserved.
//

#import "YYPTimer.h"

typedef void(^Block)(void);

@interface YYPTimer ()

@property(nonatomic, strong) dispatch_source_t timer;

@property(nonatomic, assign) NSUInteger interval;

@property(nonatomic, assign) BOOL isSuspend;

//@property(nonatomic, assign) BOOL repeat;

@property(nonatomic, copy)   Block action;

@end

@implementation YYPTimer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.interval = 1;
        self.isSuspend = YES;
//        self.repeat = YES;
    }
    return self;
}
+ (YYPTimer *)createTimerWithInterval:(NSUInteger)interval action:(nonnull void (^)(void))action repeat:(BOOL)repeat {
    YYPTimer *timer = [[YYPTimer alloc] init];
   
    [timer startTimerWithInterval:interval action:action repeat:repeat];
    
    return timer;
}
- (void)startTimerWithInterval:(NSUInteger)interval action:(void (^)(void))action repeat:(BOOL)repeat {
    self.interval = interval;
    self.action = action;
//    self.repeat = repeat;
}
- (dispatch_source_t)timer {
    if (_timer == nil) {
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
        uint64_t secondNum = (uint64_t)(self.interval * NSEC_PER_SEC);
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, secondNum, 0);
        dispatch_source_set_event_handler(_timer, self.action);

    }
    return _timer;
}
+ (NSThread *)timerThread {
    static NSThread *timerThread = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        
        timerThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadTest) object:nil];
        
        [timerThread setName:@"threadTest"];
        
        [timerThread start];
    });
    
    return timerThread;
}
- (void)threadTest {
    
}
- (void)resumeTimer
{
    if (self.isSuspend) {
        dispatch_resume(self.timer);
        self.isSuspend = NO;
    }
}
- (void)suspendTimer
{
    if (!self.isSuspend) {
        dispatch_suspend(self.timer);
        self.isSuspend = YES;
    }
}
- (void)dealloc
{
    if (_timer) {
        if (_isSuspend) {
            dispatch_resume(_timer);
        }
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
@end
