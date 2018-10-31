//
//  YYPBezierView.m
//  22222
//
//  Created by 玉岳鹏 on 2018/8/16.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "YYPBezierView.h"

#define btnWidth 4
#define btnHeight 4

@interface YYPBezierView()

@property(nonatomic, strong) NSArray <NSString *>* values;

@property(nonatomic, strong) NSArray <NSString *>* leftItems;

@property(nonatomic, strong) NSArray <NSString *>* bottomItems;

@property(nonatomic, strong) UIView *verticalCoordinatesView;// 纵坐标

@property(nonatomic, strong) UIView *abscissaView;// 横坐标

@property(nonatomic, strong) NSMutableArray <UIButton *> *points;

@property(nonatomic, strong) UIView *carveView;

@end

@implementation YYPBezierView {
    CGPoint lastPoint;
    CALayer *_baseLayer;
    CAShapeLayer *_shapeLayer1;
}
- (UIView *)carveView {
    CGFloat heightY = self.frame.size.height-20;
    CGFloat widthX = self.frame.size.width - 50;
    if (_carveView == nil) {
        _carveView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthX, heightY)];
//        _carveView.backgroundColor = [UIColor yellowColor];
    }
    return _carveView;
}
- (NSMutableArray<UIButton *> *)points {
    if (_points ==  nil) {
        _points = [NSMutableArray array];
    }
    return _points;
}
- (instancetype)initWithFrame:(CGRect)frame values:(NSArray<NSString *> *)values leftItems:(NSArray<NSString *> *)leftItems bottomItems:(NSArray<NSString *> *)bottomItems{
    self = [super initWithFrame:frame];
    if (self) {
        _values = values;
        _leftItems = leftItems;
        _bottomItems = bottomItems;
        [self createViews];
        [self bezierSet];
    }
    return self;
}
- (UIView *)verticalCoordinatesView {
    if (_verticalCoordinatesView == nil) {
        _verticalCoordinatesView = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 1, self.frame.size.height - 20)];
        _verticalCoordinatesView.backgroundColor = [UIColor lightGrayColor];
    }
    return _verticalCoordinatesView;
}
- (UIView *)abscissaView {
    if (_abscissaView == nil) {
        _abscissaView = [[UIView alloc] initWithFrame:CGRectMake(50, self.frame.size.height - 21, self.frame.size.width - 50, 1)];
        _abscissaView.backgroundColor = [UIColor lightGrayColor];
    }
    return _abscissaView;
}
- (void)createViews {
    
    CGFloat heightY = self.frame.size.height-20;
    CGFloat widthX = self.frame.size.width - 50;
    CGFloat dizengHeight = (self.frame.size.height-40)/self.leftItems.count;
    [self addSubview:self.carveView];
    [self addSubview:self.verticalCoordinatesView];
    [self addSubview:self.abscissaView];
    for (NSInteger i = 0; i < self.leftItems.count + 1; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i * dizengHeight, 50, 20)];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:12];
        if (i < self.leftItems.count) {
            label.text = self.leftItems[i];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(50 , i * heightY/3, widthX, 1)];
            line.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:line];
        }else {
            label.text = @"2";
        }
        [self addSubview:label];
    }
    
    CGFloat dizengWidth = (self.frame.size.width - 50)/self.leftItems.count;
    CGFloat singleLength = (self.frame.size.height-20)/600.0f;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50 - 2, heightY - 2, 4, 4)];
    
    for (NSInteger i = 0; i < self.bottomItems.count; i ++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50 + dizengWidth * i, self.frame.size.height - 20, dizengWidth, 20)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:12];
        label.text = self.bottomItems[i];
        [self addSubview:label];
//        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(label.center.x, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
    }
    CGFloat danweiWidth = widthX/(self.values.count );
    for (NSInteger i = 0; i < self.values.count; i ++) {
        CGFloat btnCenterY = heightY - ([self.values[i] floatValue] - 2)* singleLength * 100;//btn的中心位置高度
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((i ) * danweiWidth - 2 + 50, btnCenterY - 2, 4, 4)];
        [self.points addObject:btn];
    }
//    [self.points insertObject:btn atIndex:0];
   
//    gradientLayer.cornerRadius =

//    self.points
    
}
- (void)bezierSet {
    UIBezierPath *bezier = [UIBezierPath bezierPath];//贝塞尔曲线
    UIBezierPath *bezier1 = [UIBezierPath bezierPath];//遮罩层
    bezier1.lineCapStyle = kCGLineCapRound;
    bezier1.lineJoinStyle = kCGLineJoinMiter;
    CGFloat heightY = self.frame.size.height - 20;
    CGFloat widthX = self.frame.size.width - 50;
    CGPoint p1 = self.points.firstObject.center;
//    CGPoint p2 = self.points[1].center;
    
    [bezier moveToPoint:p1];
    [bezier1 moveToPoint:p1];
//    [bezier addCurveToPoint:CGPointMake(p2.x, p2.x) controlPoint1:CGPointMake((p1.x + p2.x)/2, p1.y) controlPoint2:CGPointMake((p1.x + p2.x)/2, p2.y)];
//    [bezier1 addCurveToPoint:CGPointMake(p2.x, p2.x) controlPoint1:CGPointMake((p1.x + p2.x)/2, p1.y) controlPoint2:CGPointMake((p1.x + p2.x)/2, p2.y)];

    for (NSInteger i = 0; i < self.points.count; i ++) {
        NSLog(@"btnFrame = %@",NSStringFromCGRect(self.points[i].frame));
        self.points[i].backgroundColor = [UIColor blueColor];
        
        if (i != 0) {
            
            UIButton *btn = self.points[i - 1];
            UIButton *btn1 = self.points[i];
            [bezier addCurveToPoint:CGPointMake(btn1.centerX, btn1.centerY) controlPoint1:CGPointMake((btn.centerX + btn1.centerX)/2, btn.centerY) controlPoint2:CGPointMake((btn.centerX + btn1.centerX)/2, btn1.centerY)];
            [bezier1 addCurveToPoint:CGPointMake(btn1.centerX, btn1.centerY) controlPoint1:CGPointMake((btn.centerX + btn1.centerX)/2, btn.centerY) controlPoint2:CGPointMake((btn.centerX + btn1.centerX)/2, btn1.centerY)];
        }
        if (i == self.points.count - 1) {
            [bezier moveToPoint:self.points[i].center];
            lastPoint = self.points[i].center;
        }
        [self addSubview:self.points[i]];
    }

    CGPoint zhezhaoLastbtn = CGPointMake(lastPoint.x, heightY);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.center = zhezhaoLastbtn;
//    label.backgroundColor = [UIColor yellowColor];
    [self addSubview:label];
    [bezier1 addLineToPoint:zhezhaoLastbtn];
    [bezier1 addLineToPoint:CGPointMake(self.points[0].centerX, heightY)];

    [bezier1 addLineToPoint:self.points[0].center];//连接最右下角的点，和最左下角的点
    
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.path = bezier1.CGPath;//遮罩层轮廓
//    shapeLayer.fillColor = [UIColor redColor].CGColor;
//
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];//渐变图层
//
//    gradientLayer.frame = CGRectMake(0, 0, widthX, heightY);
//    gradientLayer.endPoint = CGPointMake(0, 1);
//    gradientLayer.cornerRadius = 5;
//    gradientLayer.masksToBounds = YES;
//    gradientLayer.colors = [self getMaskColors];//颜色要统一都为红色。因为location为一 所以分成两份 两个颜色
//    gradientLayer.locations = @[@(0.5f)];
    
    CALayer *baseLayer = [CALayer layer];//总layer
//    [baseLayer addSublayer:gradientLayer];
//    [baseLayer setMask:shapeLayer];
    _baseLayer = baseLayer;
    [self.carveView.layer addSublayer:baseLayer];
    
    //渐变图层的动画
//    CABasicAnimation *anmi1 = [CABasicAnimation animation];
//    anmi1.keyPath = @"bounds";
//    anmi1.duration = 2.0f;
//    anmi1.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 2 * lastPoint.x, heightY)];
//
//    anmi1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    anmi1.fillMode = kCAFillModeForwards;
//    anmi1.autoreverses = NO;
//    anmi1.removedOnCompletion = NO;
    
//    [gradientLayer addAnimation:anmi1 forKey:@"bounds"];
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.path = bezier.CGPath;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.strokeColor = [UIColor redColor].CGColor;
    shapeLayer1.lineWidth = 1;
    [self.carveView.layer addSublayer:shapeLayer1];
    
    _shapeLayer1 = shapeLayer1;
    
//    CABasicAnimation *anmi = [CABasicAnimation animation];
//    anmi.keyPath = @"strokeEnd";
//    anmi.fromValue = [NSNumber numberWithFloat:0];
//    anmi.toValue = [NSNumber numberWithFloat:1.0f];
//    anmi.duration =2.0f;
//    anmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    anmi.autoreverses = NO;
    
//    [shapeLayer1 addAnimation:anmi forKey:@"stroke"];
}
- (NSArray *)getMaskColors {
    NSArray *colors = @[[self getCGColorWithColor:[UIColor redColor] alpha:0.2], [self getCGColorWithColor:[UIColor redColor] alpha:0.1]];
    return colors;
}
- (id)getCGColorWithColor:(UIColor *)color alpha:(CGFloat)alpha {
    
    CGFloat red = 0.0, green = 0.0, blue = 0, al = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&al];
    return  (__bridge id)[UIColor colorWithRed:red green:green blue:blue alpha:alpha].CGColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
