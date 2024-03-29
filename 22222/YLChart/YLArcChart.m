//
//  YLArcChart.m
//  DrawTest
//
//  Created by LELE on 17/4/11.
//  Copyright © 2017年 rect. All rights reserved.
//

#import "YLArcChart.h"
@interface YLArcChart()
{
    UIBezierPath* _bottomPath;
    UIColor* _backgroundCyclicColor;
    UIColor* _color1;
    UIColor* _color2;
    UIColor* _color3;
}
@property(nonatomic,weak)UILabel* lbl;
/**
 *  show the background cyclic,Defaule is YES
 */
@property(nonatomic,assign)BOOL showBackGroundCyclic;
/**
 *  animation duration,Defaule is 2sec
 */
@property(nonatomic,assign)CGFloat duration;

@property(nonatomic,assign)CGFloat percent;

@end
@implementation YLArcChart {
    CGFloat singleLength;
}
-(instancetype)initWithFrame:(CGRect)frame duration:(CGFloat)duration showBgCyclic:(BOOL)showBgCyclic percent:(CGFloat)percent
{
    if (self == [super initWithFrame:frame]) {
        singleLength = mainWidth/750.0f;
        [self setUpDefault];
        self.showBackGroundCyclic = showBgCyclic;
        self.duration = duration*percent;
        self.percent = percent;
        [self drawCyclicWithEndAngle:M_PI * 2];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self drawCyclicWithEndAngle:M_PI * 2 ];
//        });
    }
    return self;
}

-(void)setUpDefault
{
    self.showBackGroundCyclic = YES;
    self.duration = 0.5;
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];//[UIColor colorWithRed:55.0 / 255.0 green:64.0 / 255.0 blue:84.0 / 255.0 alpha:1.0];
    _backgroundCyclicColor = [UIColor colorWithRed:235.0 / 255.0 green:238.0 / 255.0 blue:235.0 / 255.0 alpha:0.5];
    _color1 = [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1.0];
//    _color2 = [UIColor colorWithHex:0xff1B6C10];
//    _color3 = [UIColor colorWithRed:175.0 / 255.0 green:161.0 / 255.0 blue:127.0 / 255.0 alpha:1.0];
}

-(void)drawCyclicWithEndAngle:(CGFloat)endAngle
{
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGFloat radius = self.frame.size.width * 0.5 - 15;

    if (_bottomPath == nil) {
        UIBezierPath* bottomPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2  endAngle:M_PI * 2 clockwise:YES];
        CAShapeLayer* shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = bottomPath.CGPath;
        shapeLayer.lineWidth = 3.0;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = _backgroundCyclicColor.CGColor;
        [self.layer addSublayer:shapeLayer];
        _bottomPath = bottomPath;
    }
    CGFloat cir1 = M_PI * 2 * _percent - M_PI_2;
    UIBezierPath* path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 + 0.15 endAngle:cir1 clockwise:YES];
    
    CAGradientLayer* gradientlary = [CAGradientLayer layer];
    gradientlary.frame = self.bounds;
    gradientlary.backgroundColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:gradientlary];
    
    CGFloat gradW = self.frame.size.width * 0.5;
    CAGradientLayer* grad1 = [CAGradientLayer layer];
    grad1.frame = CGRectMake(0, 0, gradW, gradW);
    grad1.colors = @[(id)[UIColor colorWithRed:89.0 / 255.0 green:211.0 / 255.0 blue:92.0 / 255.0 alpha:1.0].CGColor,(id)[UIColor colorWithHex:0xff68EC6E].CGColor];
//    grad1.locations=@[@0.15,@0.45,@0.8];
    grad1.startPoint = CGPointMake(0, 1);
    grad1.endPoint = CGPointMake(1, 0);
    [gradientlary addSublayer:grad1];
    
    CAGradientLayer* grad2 = [CAGradientLayer layer];
    grad2.frame = CGRectMake(gradW, 0, gradW, gradW);
    grad2.colors = @[(id)_color2.CGColor,(id)[UIColor colorWithRed:43.0 / 255.0 green:133.0 / 255.0 blue:34.0 / 255.0 alpha:1.0].CGColor];
//    grad2.locations=@[@0.4,@0.7,@0.9];
    grad2.startPoint = CGPointMake(0, 0);
    grad2.endPoint = CGPointMake(1, 1);
    [gradientlary addSublayer:grad2];
    
    CAGradientLayer* grad3 = [CAGradientLayer layer];
    grad3.frame = CGRectMake(gradW, gradW, gradW, gradW);
    grad3.colors = @[(id)[UIColor colorWithRed:43.0 / 255.0 green:133.0 / 255.0 blue:34.0 / 255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:97.0 / 255.0 green:226.0 / 255.0 blue:103.0 / 255.0 alpha:1.0].CGColor];
//    grad3.locations=@[@0.25,@0.65,@0.9];
    grad3.startPoint = CGPointMake(1, 0);
    grad3.endPoint = CGPointMake(0, 1);
    [gradientlary addSublayer:grad3];

    CAGradientLayer* grad4 = [CAGradientLayer layer];
    grad4.frame = CGRectMake(0, gradW, gradW, gradW);
    grad4.colors = @[(id)[UIColor colorWithRed:97.0 / 255.0 green:226.0 / 255.0 blue:103.0 / 255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:89.0 / 255.0 green:211.0 / 255.0 blue:92.0 / 255.0 alpha:1.0].CGColor];
//    grad4.locations=@[@0.0,@0.7];
    grad4.startPoint = CGPointMake(1, 1);
    grad4.endPoint = CGPointMake(0, 0);
    [gradientlary addSublayer:grad4];
    
    CAShapeLayer* gressLayer = [CAShapeLayer layer];
    gressLayer.path = path.CGPath;
    gressLayer.lineCap = @"round";
//    gressLayer.miterLimit = @"round";
    gressLayer.lineWidth = 22 * singleLength;
    gressLayer.fillColor = [UIColor clearColor].CGColor;
    gressLayer.strokeColor = [UIColor blueColor].CGColor;
    gradientlary.mask = gressLayer;
    
    [self showAnimationWith:gressLayer];
}


-(void)showAnimationWith:(CAShapeLayer*)layer
{
    CABasicAnimation *ani = [ CABasicAnimation animationWithKeyPath : NSStringFromSelector ( @selector (strokeEnd))];
    ani.fromValue = @0;
    ani.toValue = @1;
    ani.duration = self.duration;
    [layer addAnimation:ani forKey:NSStringFromSelector(@selector(strokeEnd))];
}

@end
