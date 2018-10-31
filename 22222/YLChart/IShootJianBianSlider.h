//
//  IShootJianBianSlider.h
//  IShootApp
//
//  Created by 扶摇先生 on 2017/10/31.
//  Copyright © 2017年 ZH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IShootJianBianSlider : UIView

@property(nonatomic, strong) UILabel *titleLabel;
@property (nonatomic,assign) CGFloat percent;

@property (nonatomic,assign) CGFloat duration;
@property(nonatomic, strong) CAGradientLayer *layer1;
@property(nonatomic, strong) UIView *slider;
- (instancetype)initWithFrame:(CGRect)frame percent:(CGFloat)percent ;
- (void)changeLayers;
@end
