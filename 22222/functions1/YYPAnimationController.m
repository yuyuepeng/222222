//
//  YYPAnimationController.m
//  22222
//
//  Created by 扶摇先生 on 2021/3/18.
//  Copyright © 2021 玉岳鹏. All rights reserved.
//

#import "YYPAnimationController.h"

@interface YYPAnimationController ()<CAAnimationDelegate>

@property(nonatomic, strong) UIScrollView *scollView;

@property(nonatomic, strong) UIView *layerView;

@property(nonatomic, strong) CALayer *colorLayer;

@end

@implementation YYPAnimationController

- (UIScrollView *)scollView {
    if (_scollView == nil) {
        _scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight)];
        _scollView.contentSize = CGSizeMake(mainWidth, mainHeight * 5);
    }
    return _scollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scollView];
    //平移动画
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 80, 80)];
    view1.backgroundColor = [UIColor purpleColor];
    [view1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap0:)]];
    view1.tag = 201;
    [self.scollView addSubview:view1];
    
    //组动画
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 160, 80, 80)];
    view2.backgroundColor = [UIColor brownColor];
    [view2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)]];
    [self.scollView addSubview:view2];
    
    
    self.layerView = [[UIView alloc] initWithFrame:CGRectMake(160, 260, 80, 80)];
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = self.layerView.bounds;
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;


    [self.scollView addSubview:self.layerView];
    [self.layerView.layer addSublayer:self.colorLayer];
    [self.scollView addSubview:self.layerView];
    // Do any additional setup after loading the view.
}
- (void)tap0:(UITapGestureRecognizer *)tap {
    UIView *view = tap.view;
//    [view.layer removeAllAnimations];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(40, 90)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(mainWidth - 40, 90)];
    animation.duration = 1;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"pingyi"];
    NSLog(@"%@,%@",NSStringFromCGRect(view.frame),NSStringFromCGRect(view.layer.frame));
    [CATransaction begin];//隐式动画，如果不设置时间，默认0.25秒，其实是Core Animation在每个RunLoop周期中会自动开始一次新的事务，即使你不显式的使用[CATranscation begin]开始一次事务，任何在一次RunLoop运行时循环中属性的改变都会被集中起来，执行默认0.25秒的动画。

    [CATransaction setAnimationDuration:2.0];
    CGFloat red = arc4random() / (CGFloat)INT_MAX;

    CGFloat green = arc4random() / (CGFloat)INT_MAX;

    CGFloat blue = arc4random() / (CGFloat)INT_MAX;

    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    [CATransaction commit];

}
- (void)tap1:(UITapGestureRecognizer *)tap {
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 1.0f;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;

    UIView *view = tap.view;
//    [view.layer removeAllAnimations];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.fromValue = [UIColor brownColor];
    animation.toValue = [UIColor greenColor];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    CAKeyframeAnimation *frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    frameAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(40, 200)],[NSValue valueWithCGPoint:CGPointMake(200, 160)],[NSValue valueWithCGPoint:CGPointMake(mainWidth - 40, 200)]];
    frameAnimation.removedOnCompletion = NO;
    frameAnimation.fillMode = kCAFillModeForwards;
    
    groupAnimation.animations = @[animation,frameAnimation];

    [view.layer addAnimation:groupAnimation forKey:@"pingyi1"];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([anim isKindOfClass:[CABasicAnimation class]]) {
        CABasicAnimation *ani = (CABasicAnimation *)anim;
    
        if ([ani.keyPath isEqualToString:@"position"]) {
            if (flag) {
                UIView *view = [self.scollView viewWithTag:201];
                view.frame = CGRectMake(mainWidth - 80, 50, 80, 80);
            }
        }
    }
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
