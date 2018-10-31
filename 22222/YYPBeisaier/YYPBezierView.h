//
//  YYPBezierView.h
//  22222
//
//  Created by 玉岳鹏 on 2018/8/16.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYPBezierView : UIView

/**
 实例化

 @param frame 位置大小
 @param values 贝泽尔曲线上的点Y坐标
 @param leftItems 左侧Y轴上的label
 @param bottomItems 底部X轴上的label
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame values:(NSArray <NSString *>*)values leftItems:(NSArray <NSString*>*)leftItems bottomItems:(NSArray <NSString*>*)bottomItems;

@end
