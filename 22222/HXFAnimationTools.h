//
//  HXFAnimationTools.h
//  22222
//
//  Created by 玉岳鹏 on 2018/7/9.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface HXFAnimationTools : NSObject
#pragma mark === 永久闪烁的动画 ======
+ (CABasicAnimation *)opacityForever_Animation:(float)time;

#pragma mark =====横向、纵向移动===========
+ (CABasicAnimation *)time:(float)time X:(NSNumber *)x;

+ (CABasicAnimation *)time:(float)time Y:(NSNumber *)y;

#pragma mark =====缩放-=============
+ (CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repertTimes;

#pragma mark =====组合动画-=============
+ (CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes;

#pragma mark =====路径动画-=============
+ (CAKeyframeAnimation *)keyframeAnimation:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes;

#pragma mark ====旋转动画======
+ (CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount delegate:(id <CAAnimationDelegate>) delegate;
@end
