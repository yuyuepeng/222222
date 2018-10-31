//
//  IShootJianBianSliderJia.m
//  IShootApp
//
//  Created by 扶摇先生 on 2017/11/24.
//  Copyright © 2017年 ZH. All rights reserved.
//

#import "IShootJianBianSliderJia.h"

@interface IShootJianBianSliderJia()

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIImageView *lineView;

@property (nonatomic,assign) int ratio;  // 记录百分比 用于数字跳动

@property (nonatomic, strong) UILabel *scoreLabel;

@property(nonatomic, strong) UIView *circle;

@end

@implementation IShootJianBianSliderJia {
    CGFloat singleLength;
    CGFloat danweiChang;
    CGFloat newWidth;
    NSTimer *timer;
}
- (UIImageView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIImageView alloc] initWithFrame:CGRectMake(46 * singleLength, 78 * singleLength, 552 * singleLength, 2 * singleLength)];
        _lineView.image = [UIImage imageNamed:@"jiandingxuxian"];
    }
    return _lineView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(46 * singleLength, 16 * singleLength, 80 * singleLength, 30 * singleLength)];
        _titleLabel.textColor = RGB(141, 141, 141);
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"外观";
    }
    return _titleLabel;
}
- (UIView *)circle {
    if (_circle == nil) {
        _circle = [[UIView alloc] initWithFrame:CGRectMake(mainWidth - 65 * singleLength, 54 * singleLength, 22 * singleLength, 22 * singleLength)];
        //        _circle.layer.masksToBounds = YES;
        _circle.backgroundColor = RGB(207, 46, 65);
        //        _circle.layer.cornerRadius = 11 * singleLength;
    }
    return _circle;
}
- (UILabel *)scoreLabel {
    if (_scoreLabel == nil) {
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.lineView.right + 25 * singleLength, 54 * singleLength, 30, 30 * singleLength)];
        _scoreLabel.textAlignment = NSTextAlignmentLeft;
        _scoreLabel.textColor = RGB(141, 141, 141);
        _scoreLabel.font = [UIFont systemFontOfSize:12];
    }
    return _scoreLabel;
}
- (instancetype)initWithFrame:(CGRect)frame percent:(CGFloat)percent
{
    self = [super initWithFrame:frame];
    _percent = percent;
    
    singleLength = mainWidth/750.0f;
    danweiChang =  percent/100.0f ;
    danweiChang =  danweiChang * 552 * singleLength;
    danweiChang = danweiChang/15;
    newWidth = 0;
    if (self) {
//        [self addSubview:self.lineView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.scoreLabel];
        self.scoreLabel.text = [NSString stringWithFormat:@"%ld",(NSInteger)_percent];
        [self addSubview:self.circle];
        [self drawLayerAnimation];
        
        //        [self changeLayers];
    }
    return self;
}
- (void)changeLayers {
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(lengthde) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)lengthde {
    newWidth += danweiChang;
    _layer1.frame = CGRectMake(0 * singleLength, 0 * singleLength, newWidth, 11 * singleLength);
    if (newWidth >= 552 * singleLength * _percent / 100) {
        [timer invalidate];
        timer = nil;
    }
}
- (void)drawLayerAnimation {
    _slider = [[UIView alloc] init];
    [self addSubview:_slider];
    _slider.layer.masksToBounds = YES;
    _slider.layer.cornerRadius = 5.5 * singleLength;
    _slider.frame = CGRectMake(46 * singleLength, 62 * singleLength, 552 * singleLength, 11 * singleLength);
    _layer1 = [CAGradientLayer layer];
    _layer1.startPoint = CGPointMake(0, 0.5);//（0，0）表示从左上角开始变化。默认值是(0.5,0.0)表示从x轴为中间，y为顶端的开始变化
    _layer1.endPoint = CGPointMake(1, 0.5);//（1，1）表示到右下角变化结束。默认值是(0.5,1.0)  表示从x轴为中间，y为低端的结束变化
    _layer1.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithRed:159.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0].CGColor, (id)[UIColor colorWithRed:244.0/255.0 green:85.0/255.0 blue:98.0/255.0 alpha:1.0].CGColor, nil];
    _layer1.frame = CGRectMake(0 * singleLength, 0 * singleLength, 0 * singleLength, 11 * singleLength);
    _layer1.cornerRadius = 5.5 * singleLength;
    [_slider.layer insertSublayer:_layer1 atIndex:0];
    //    layer.locations = @[@0.0f, @0.2f, @1.0f];//渐变颜色的区间分布，locations的数组长度和color一致，这个值一般不用管它，默认是nil，会平均分布
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
