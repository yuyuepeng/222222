
//
//  HudController.m
//  22222
//
//  Created by 玉岳鹏 on 2019/7/10.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "HudController.h"

@interface HudController ()

@property(nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation HudController

// propertyname = hash
// propertyname = superclass
// propertyname = description
// propertyname = debugDescription
// propertyname = shadowOffset
// propertyname = shadowColor
// propertyname = internalView
// propertyname = width
// propertyname = hasShadow
// propertyname = spokeCount
// propertyname = innerRadius
// propertyname = spokeFrameRatio
// propertyname = spokeImages
// propertyname = spokeHighlightImages
// propertyname = clockWise
// propertyname = spinning
// propertyname = spinningDuration
// propertyname = useArtwork
// propertyname = artBackupKeyString
// propertyname = highlightArtBackupKeyString
// propertyname = useOutlineShadow
// propertyname = activityIndicatorViewStyle
// propertyname = hidesWhenStopped
// propertyname = color
// propertyname = animating


- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    [self.view addSubview:self.activityIndicator];
    //设置小菊花的frame
    self.activityIndicator.frame= CGRectMake(100, 100, 100, 100);
    //设置小菊花颜色
    self.activityIndicator.color = [UIColor whiteColor];
//    UIView *view = (UIView *)[self.activityIndicator valueForKey:@"internalView"];
////    view.backgroundColor = [UIColor brownColor];
//    view.frame = CGRectMake(0, 0, 30, 30);
//    view.center = CGPointMake(50, 50);
    UIButton *littleButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
    [littleButton setTitle:@"dasdasda" forState:UIControlStateNormal];
    littleButton.backgroundColor = [UIColor blackColor];
    
    UIView *view = (UIView *)[littleButton valueForKey:@"imageView"];
    view.backgroundColor = [UIColor redColor];
    UILabel *label = [littleButton valueForKey:@"titleLabel"];
    label.text = @"我爱你";
    [self.view addSubview:littleButton];
    //设置背景颜色
    self.activityIndicator.backgroundColor = [UIColor blackColor];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    self.activityIndicator.hidesWhenStopped = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.activityIndicator startAnimating];
    
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([UIButton class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        //通过property_getName函数获得属性的名字
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSLog(@"propertyname = %@",propertyName);
        
        //通过property_getAttributes函数可以获得属性的名字和@encode编码
//        NSString * propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    }
    free(properties);   
    // Do any additional setup after loading the view.
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
