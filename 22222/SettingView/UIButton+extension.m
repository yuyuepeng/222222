
//
//  UIButton+extension.m
//  22222
//
//  Created by 扶摇先生 on 2019/11/1.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "UIButton+extension.h"

static const char * topKey = "topKey";
static const char * leftKey = "leftKey";
static const char * bottomKey = "bottomKey";
static const char * rightKey = "rightKey";

@implementation UIButton (extension)
- (void)setClickAreaWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right{
    objc_setAssociatedObject(self, topKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, leftKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, bottomKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, rightKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)clickAreaRect{
    float top = [objc_getAssociatedObject(self, topKey) floatValue];
    float left = [objc_getAssociatedObject(self, leftKey) floatValue];
    float bottom = [objc_getAssociatedObject( self, bottomKey) floatValue];
    float right = [objc_getAssociatedObject(self, rightKey) floatValue];
    if (top != 0 && left != 0 && bottom != 0 && right != 0) {
        return CGRectMake(self.bounds.origin.x - left, self.bounds.origin.y - top, self.bounds.size.width + left + right, self.bounds.size.height + top + bottom);
    }else{
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    CGRect rect = [self clickAreaRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }else{
        //判断点击点是否在rect内
        return CGRectContainsPoint(rect, point) ? self : nil;
    }
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {

    return YES;
}
@end
