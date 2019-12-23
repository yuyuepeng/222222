//
//  RMYDoubleSidedLayer.m
//  22222
//
//  Created by 扶摇先生 on 2019/12/20.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "RMYDoubleSidedLayer.h"

@implementation RMYDoubleSidedLayer
- (id)init {
    if ((self = [super init])) {
        [self setDoubleSided:YES];
    }
    return self;
}

- (void)layoutSublayers {
    [super layoutSublayers];
    
    [_frontLayer setFrame:self.bounds];
    [_backLayer setFrame:self.bounds];
}


#pragma mark - Properties

- (void)setFrontLayer:(CALayer *)frontLayer{
    if (_frontLayer != frontLayer) {
        [_frontLayer removeFromSuperlayer];
        _frontLayer = frontLayer;
        [_frontLayer setDoubleSided:NO];
        [self addSublayer:frontLayer];
        [self setNeedsLayout];
    }
}

- (void)setBackLayer:(CALayer *)backLayer {
    if (_backLayer != backLayer) {
        [_backLayer removeFromSuperlayer];
        _backLayer = backLayer;
        [_backLayer setDoubleSided:NO];
        CATransform3D transform = CATransform3DMakeRotation(M_PI, 1., 0., 0.);
        [_backLayer setTransform:transform];
        [self addSublayer:_backLayer];
        [self setNeedsLayout];
    }
}

@end
