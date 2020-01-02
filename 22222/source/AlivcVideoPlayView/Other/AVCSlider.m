//
//  AVCSlider.m
//  Slider-test
//
//  Created by aliyun on 2019/4/25.
//  Copyright © 2019 Aliyun. All rights reserved.
//

#import "AVCSlider.h"

#define THUMB_WIDTH  15

@implementation AVCSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setThumbImage:[AlivcImage imageNamed:@"thumbImage"] forState:UIControlStateNormal];
        [self setThumbImage:[AlivcImage imageNamed:@"thumbImage"] forState:UIControlStateHighlighted];
    }
    return self;
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    return CGRectMake((self.frame.size.width-THUMB_WIDTH)*value+1, (self.frame.size.height-THUMB_WIDTH)/2, THUMB_WIDTH, THUMB_WIDTH);
}

@end
