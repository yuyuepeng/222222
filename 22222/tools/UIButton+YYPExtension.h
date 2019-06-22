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

@property(nonatomic, strong) NSMutableDictionary *stateBackgroundColor;

- (void)setBackgroundColor:(UIColor *)backgroundColor state:(UIControlState)state;

- (void)setUserInteractionDisabledBackgroundColor:(UIColor *)backgroundColor;
@end

NS_ASSUME_NONNULL_END
