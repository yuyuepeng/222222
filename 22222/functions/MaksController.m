//
//  MaksController.m
//  22222
//
//  Created by 玉岳鹏 on 2018/10/10.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "MaksController.h"

@interface MaksController ()

@end

@implementation MaksController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(110.0, 110.0, 110.0, 110.0);
    view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view];
    
    view.layer.mask = [self maskStyle2:view.bounds];

    // Do any additional setup after loading the view.
}
- (CAShapeLayer *)maskStyle2:(CGRect)rect {
    //
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    
    //    CGFloat x = rect.size.width/2.0;
    //    CGFloat y = rect.size.height/2.0;
    //    CGFloat radius = MIN(x, y)*0.8;
    //
    //    UIBezierPath *cycle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x, y)
    //                                                         radius:radius
    //                                                     startAngle:0.0
    //                                                       endAngle:2*M_PI
    //                                                      clockwise:YES];
    //    [path appendPath:cycle];
    UIBezierPath *juxing = [UIBezierPath bezierPath];
    [juxing moveToPoint:CGPointMake(10, 10)];
    [juxing addCurveToPoint:CGPointMake(90, 10) controlPoint1:CGPointMake(20, 5) controlPoint2:CGPointMake(60, 15)];
    [juxing addCurveToPoint:CGPointMake(90, 100) controlPoint1:CGPointMake(85, 20) controlPoint2:CGPointMake(105, 70)];
    [juxing addCurveToPoint:CGPointMake(10, 100) controlPoint1:CGPointMake(60, 95) controlPoint2:CGPointMake(20, 105)];
    [juxing addLineToPoint:CGPointMake(10, 10)];
    [path appendPath:juxing];
    
    //
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [path CGPath];
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    
    return maskLayer;
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
