//
//  UIButton+YYPExtension.h
//  22222
//
//  Created by 扶摇先生 on 2019/6/21.
//  Copyright © 2019年 玉岳鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIButton (YYPExtension)

/**
 存放颜色和状态字符串的字典
 */
@property(nonatomic, strong) NSMutableDictionary *stateBackgroundColor;

/**
 根据状态设置背景颜色

 @param backgroundColor 背景色
 @param state 状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor state:(UIControlState)state;

/**
 设置不可点击下的背景色

 @param backgroundColor 背景色
 */
- (void)setUserInteractionDisabledBackgroundColor:(UIColor *)backgroundColor;
@end

NS_ASSUME_NONNULL_END
