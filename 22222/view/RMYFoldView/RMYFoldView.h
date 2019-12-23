//
//  RMYFoldView.h
//  22222
//
//  Created by 扶摇先生 on 2019/12/20.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    RMYFoldViewTickDirectionDown,
    RMYFoldViewTickDirectionUp,
} RMYFoldViewTickDirection;

typedef enum {
    RMYFoldViewAllowedPanDirectionNone     = 0,
    RMYFoldViewAllowedPanDirectionDown     = 1 << 0,
    RMYFoldViewAllowedPanDirectionUp       = 1 << 1,
} RMYFoldViewAllowedPanDirection;

NS_ASSUME_NONNULL_BEGIN

@interface RMYFoldView : UIView

@property (nonatomic, strong) RMYFoldView *frontView;
@property (nonatomic, strong) RMYFoldView *backView;
@property (nonatomic, assign) CFTimeInterval duration; // default .5

@property (nonatomic, assign) BOOL panning; // default NO. If set to YES, this view will get an UIPanGestureRecognizer
@property (nonatomic, assign) RMYFoldViewAllowedPanDirection allowedPanDirections; // default RMYFoldViewAllowedPanDirectionNone
- (instancetype)initWithbackView:(RMYFoldView *)backView frontView:(RMYFoldView *)frontView;
- (void)tick:(RMYFoldViewTickDirection)direction animated:(BOOL)animated completion:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
