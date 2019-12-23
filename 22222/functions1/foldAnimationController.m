//
//  foldAnimationController.m
//  22222
//
//  Created by 扶摇先生 on 2019/12/18.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "foldAnimationController.h"
#import "RMYFoldView.h"
#import "RMYDetailController.h"
@interface foldAnimationController ()


@property(nonatomic, strong) UIView *topView;

@property(nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) CAGradientLayer *gradientL;

@property(nonatomic, strong) UIView *bigView;


@end

@implementation foldAnimationController

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(100, 120, 150, 150)];
        UILabel *label = [[UILabel alloc] initWithFrame:_topView.bounds];
        label.text = @"019-12-18 18:41:57.687590+0800 22222[88578:19057467] hahaha Amy2019-12-18 18:41:57.688811+08";
        label.numberOfLines = 0;
        [_topView addSubview:label];
//        _topView.backgroundColor = [UIColor brownColor];
    }
    return _topView;
}
- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:self.topView.frame];
        UILabel *label = [[UILabel alloc] initWithFrame:_topView.bounds];
        label.text = @"019-12-18 18:41:57.687590+0800 22222[88578:19057467] hahaha Amy2019-12-18 18:41:57.688811+08";
        label.numberOfLines = 0;
        [_bottomView addSubview:label];
//        _bottomView.backgroundColor = [UIColor blueColor];
    }
    return _bottomView;
}
- (UIView *)bigView {
    if (_bigView == nil) {
        _bigView = [[UIView alloc] initWithFrame:CGRectMake(100, 45, 150, 300)];
        _bigView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    }
    return _bigView;
}
- (void)panAction:(UIPanGestureRecognizer *)pan {
    //获取移动的偏移量
        CGPoint transP = [pan translationInView:pan.view];
        //让上部图片开始旋转
        CGFloat angle = transP.y * M_PI / 200;

        //近大远小效果
        CATransform3D transform = CATransform3DIdentity;
        //眼睛离屏幕的距离(透视效果)
        transform.m34 = -1 / 300.0;

        self.gradientL.opacity = transP.y * 1 / 200.0;
    if (transP.y > 0) {
        self.topView.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);

    }else  if (transP.y < 0){
        self.bottomView.layer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);
    }



        if (pan.state == UIGestureRecognizerStateEnded) {
            self.gradientL.opacity = 0;
            //上部图片复位
            //usingSpringWithDamping:弹性系数
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
//                if (transP.y > 100) {
//                    self.topView.layer.transform = CATransform3DRotate(transform, -M_PI, 1, 0, 0);
//                }else  if (transP.y < -100){
//                    self.bottomView.layer.transform = CATransform3DRotate(transform, -M_PI, 1, 0, 0);
//                }
                if (transP.y > 0) {
                    self.topView.layer.transform = CATransform3DIdentity;

                }else {
                    self.bottomView.layer.transform = CATransform3DIdentity;
                }
            } completion:^(BOOL finished) {

            }];
            
        }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.topView];
//    [self.view addSubview:self.bottomView];
//    [self.view addSubview:self.bigView];
//    [self.bigView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)]];
//    //1.让上部图片只显示上半部分
//    self.topView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
//    //2.让下部图片只显示下半部分
//    self.bottomView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
//
//    self.topView.layer.anchorPoint = CGPointMake(0.5, 1);
//    self.bottomView.layer.anchorPoint = CGPointMake(0.5, 0);
//
//    //设置渐变层
//    CAGradientLayer *gradidentL = [CAGradientLayer layer];
//    gradidentL.frame = self.bottomView.bounds;
//    gradidentL.opacity = 0;
//    gradidentL.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
//    self.gradientL = gradidentL;
//    [self.bottomView.layer addSublayer:gradidentL];
//
//    // Do any additional setup after loading the view.
//}

    RMYFoldView *next = [[RMYFoldView alloc] init];
    next.frame = CGRectMake(0, Height_NavBar, mainWidth, mainHeight - Height_NavBar);
    next.backgroundColor = [UIColor yellowColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"2";
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:60];
    [next addSubview:label];
    
    
    RMYFoldView *cur = [[RMYFoldView alloc] initWithbackView:nil frontView:next];
    cur.frame = CGRectMake(0, Height_NavBar, mainWidth, mainHeight - Height_NavBar);
    cur.backgroundColor = [UIColor brownColor];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label1.text = @"1";
    label1.backgroundColor = [UIColor whiteColor];
    label1.font = [UIFont boldSystemFontOfSize:60];
    [cur addSubview:label1];
    next.backView = cur;
    [self.view addSubview:cur];
   
    
    
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
