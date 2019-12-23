//
//  RMYGradientOverlayLayer.m
//  22222
//
//  Created by 扶摇先生 on 2019/12/20.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "RMYGradientOverlayLayer.h"

@interface RMYGradientOverlayLayer()

@property (nonatomic, assign) CGFloat minimumOpacity;
@property (nonatomic, assign) CGFloat maximumOpacity;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CALayer *gradientMaskLayer;

@end

@implementation RMYGradientOverlayLayer

- (id)initWithStyle:(RMYGradientOverlayLayerType)type segment:(RMYGradientOverlayLayerSegment)segment {
    if ((self = [super init])) {
        _type = type;
        _segment = segment;
        
        [self setMasksToBounds:YES];
        [self addSublayer:self.gradientLayer];
        [self setContentsScale:[[UIScreen mainScreen] scale]];
        
        _minimumOpacity = 0.;
        
        [self setGradientMaskLayer:[CALayer layer]];
        [_gradientMaskLayer setContentsScale:[[UIScreen mainScreen] scale]];
        [_gradientLayer setMask:_gradientMaskLayer];
        
        if (type == RMYGradientOverlayLayerTypeFace) {
            [_gradientLayer setColors:[NSArray arrayWithObjects:
                                       (__bridge id)[UIColor colorWithWhite:0. alpha:.5].CGColor,
                                       (__bridge id)[UIColor colorWithWhite:0. alpha:1.].CGColor,
                                       nil]];
            
            [_gradientLayer setLocations:[NSArray arrayWithObjects:
                                          [NSNumber numberWithFloat:0.],
                                          [NSNumber numberWithFloat:1.],
                                          nil]];
            
            _maximumOpacity = .75;
        } else {
            [_gradientLayer setColors:[NSArray arrayWithObjects:
                                     (__bridge id)[UIColor colorWithWhite:0. alpha:0.].CGColor,
                                     (__bridge id)[UIColor colorWithWhite:0. alpha:.5].CGColor,
                                     (__bridge id)[UIColor colorWithWhite:0. alpha:1.].CGColor,
                                     nil]];
            
            [_gradientLayer setLocations:[NSArray arrayWithObjects:
                                        [NSNumber numberWithFloat:.2],
                                        [NSNumber numberWithFloat:.4],
                                        [NSNumber numberWithFloat:1.],
                                        nil]];
            

            _maximumOpacity = 1.;
        }
        
        if (segment == RMYGradientOverlayLayerSegmentTop) {
            [self setContentsGravity:kCAGravityBottom];
            
            [_gradientLayer setStartPoint:CGPointMake(0., 0.)];
            [_gradientLayer setEndPoint:CGPointMake(0., 1.)];
            
            [_gradientMaskLayer setContentsGravity:kCAGravityBottom];
        } else {
            [self setContentsGravity:kCAGravityTop];
            
            [_gradientLayer setStartPoint:CGPointMake(0., 1.)];
            [_gradientLayer setEndPoint:CGPointMake(0., 0.)];
            
            [_gradientMaskLayer setContentsGravity:kCAGravityTop];
        }
        
        [_gradientLayer setOpacity:_minimumOpacity];
        

    }
    return self;
}

- (void)layoutSublayers {
    [super layoutSublayers];
    [_gradientLayer setFrame:self.bounds];
    [_gradientMaskLayer setFrame:self.bounds];
}

#pragma mark - Properties

- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [[CAGradientLayer alloc] init];
        [_gradientLayer setFrame:self.bounds];
    }
    return _gradientLayer;
}

- (CGFloat)gradientOpacity {
    return _gradientLayer.opacity;
}


- (void)setGradientOpacity:(CGFloat)opacity {
//    [_gradientLayer setOpacity:(opacity * (_maximumOpacity - _minimumOpacity) + _minimumOpacity)];
}

- (void)setContents:(id)contents {
    [super setContents:contents];
    
    [_gradientMaskLayer setContents:contents];
}

@end
