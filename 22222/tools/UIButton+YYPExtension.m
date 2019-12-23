//
//  UIButton+YYPExtension.m
//  22222
//
//  Created by 扶摇先生 on 2019/6/21.
//  Copyright © 2019年 玉岳鹏. All rights reserved.
//

#import "UIButton+YYPExtension.h"


static const char * stateBackgroundColorID = "stateBackgroundColorID";

static NSString *yypNormal = @"yypNormal";

static NSString *yypHighlighted = @"yypHighlighted";

static NSString *yypDisabled = @"yypDisabled";

static NSString *yypSelected = @"yypSelected";

static NSString *yypUserDisabled = @"yypUserDisabled";


@implementation UIButton (YYPExtension) 

- (void)setStateBackgroundColor:(NSMutableDictionary *)stateBackgroundColor {
    objc_setAssociatedObject(self, stateBackgroundColorID, stateBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}
- (NSMutableDictionary *)stateBackgroundColor {
    return objc_getAssociatedObject(self, stateBackgroundColorID);

}
- (void)setBackgroundColor:(UIColor *)backgroundColor state:(UIControlState)state {
    if (!self.stateBackgroundColor) {
        self.stateBackgroundColor = [NSMutableDictionary dictionary];
    }
    [self.stateBackgroundColor setObject:backgroundColor forKey:[self yyp_stringForUIControlState:state]];
}
- (void)setUserInteractionDisabledBackgroundColor:(UIColor *)backgroundColor {
    if (!self.stateBackgroundColor) {
        self.stateBackgroundColor = [NSMutableDictionary dictionary];
    }
    [self.stateBackgroundColor setObject:backgroundColor forKey:yypUserDisabled];
}
- (NSString *)yyp_stringForUIControlState:(UIControlState)state {
    NSString *yyp_string;
    switch (state) {
        case UIControlStateNormal:
            yyp_string = yypNormal;
            break;
        case UIControlStateHighlighted:
            yyp_string = yypHighlighted;
            break;
        case UIControlStateDisabled:
            yyp_string = yypDisabled;
            break;
        case UIControlStateSelected:
            yyp_string = yypSelected;
            break;
        default:
            yyp_string = yypNormal;
            break;
    }
    return yyp_string;
}
//- (void)setSelected:(BOOL)selected {
//    if (self.stateBackgroundColor) {
//        if (selected) {
//            self.backgroundColor = (UIColor *)[self.stateBackgroundColor objectForKey:yypSelected];
//        }else {
//            self.backgroundColor = (UIColor *)[self.stateBackgroundColor objectForKey:yypNormal];
//        }
//    }else {
//        [super setSelected:selected];
//    }
    
//}
//- (void)setHighlighted:(BOOL)highlighted {
//    if (self.stateBackgroundColor) {
//        if (highlighted) {
//            UIColor *color = (UIColor *)[self.stateBackgroundColor objectForKey:yypHighlighted];
//            if (!color) {
//                color = [UIColor lightGrayColor];
//            }
//            self.backgroundColor = color;
//        }else {
//
//        }
//    }else {
//        [super setHighlighted:highlighted];
//    }
    
//}
//- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
//    if (self.stateBackgroundColor) {
//        if (!userInteractionEnabled) {
//            self.backgroundColor = (UIColor *)[self.stateBackgroundColor objectForKey:yypUserDisabled];
//        }else {
//            self.backgroundColor = (UIColor *)[self.stateBackgroundColor objectForKey:yypNormal];
//        }
//    }else {
//        [super setUserInteractionEnabled:userInteractionEnabled];
//    }
    
//}

@end
