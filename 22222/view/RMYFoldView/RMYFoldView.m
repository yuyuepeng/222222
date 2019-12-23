//
//  RMYFoldView.m
//  22222
//
//  Created by 扶摇先生 on 2019/12/20.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "RMYFoldView.h"
#import "RMYDoubleSidedLayer.h"
#import "RMYGradientOverlayLayer.h"
#import "UIView+RMYExtra.h"
@interface RMYFoldView()

@property (nonatomic, strong) RMYGradientOverlayLayer *topFaceLayer;
@property (nonatomic, strong) RMYGradientOverlayLayer *bottomFaceLayer;
@property (nonatomic, strong) RMYDoubleSidedLayer *tickLayer;
@property (nonatomic, strong) CALayer *flipLayer;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

- (void)_setup;
- (void)_initializeTick:(RMYFoldViewTickDirection)direction;
- (void)_finalizeTick:(void (^)(void))completion;
- (void)_pan:(UIPanGestureRecognizer *)gestureRecognizer;

@end

@implementation RMYFoldView {
    struct {
        unsigned int ticking:1;
        unsigned int panning:1;
    } _flags;
    
    RMYFoldViewTickDirection _panningDirection;
    
    CGPoint _initialPanPosition;
    CGPoint _lastPanPosition;
}
- (instancetype)initWithbackView:(RMYFoldView *)backView frontView:(RMYFoldView *)frontView {
    self = [super init];
    if (backView) {
        [self setBackView:backView];
    }
    [self setFrontView:frontView];
    _duration = 1.0f;
    _panning = YES;
    [self addGestureRecognizer:self.panGestureRecognizer];
    _allowedPanDirections = RMYFoldViewAllowedPanDirectionUp | RMYFoldViewAllowedPanDirectionDown;
    if (self) {
        [self _setup];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame]))
        [self _setup];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder]))
        [self _setup];
    return self;
}

- (id)init {
    if ((self = [super init]))
        [self _setup];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_frontView setFrame:self.bounds];
    [_backView setFrame:self.bounds];
}

#pragma mark - Properties

- (void)setFrontView:(RMYFoldView *)frontView {
    if (_frontView.superview)
        [_frontView removeFromSuperview];
    
    _frontView = frontView;
    [self addSubview:frontView];
}

- (void)setPanning:(BOOL)panning {
    if (_panning != panning) {
        _panning = panning;
        
        if (_panning)
            [self addGestureRecognizer:self.panGestureRecognizer];
        else
            [self removeGestureRecognizer:self.panGestureRecognizer];
    }
}

- (UIPanGestureRecognizer *)panGestureRecognizer {
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_pan:)];
    }
    
    return _panGestureRecognizer;
}

#pragma mark - Private

- (void)_setup {
    _duration = .5;
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void)_initializeTick:(RMYFoldViewTickDirection)direction {
    [self setFlipLayer:[CALayer layer]];
    [_flipLayer setFrame:self.layer.bounds];
    
    CATransform3D perspective = CATransform3DIdentity;
    float zDistanse = 400.;
    perspective.m34 = 1. / -zDistanse;
    [_flipLayer setSublayerTransform:perspective];
    
    [self.layer addSublayer:_flipLayer];
    
    UIImage *frontImage = [_frontView image];
    UIImage *backImage = [_backView image];
    
    // Face layers
    // Top
    [self setTopFaceLayer:[[RMYGradientOverlayLayer alloc] initWithStyle:RMYGradientOverlayLayerTypeFace
                                                                segment:RMYGradientOverlayLayerSegmentTop]];
    
    [_topFaceLayer setFrame:CGRectMake(0., 0., _flipLayer.frame.size.width, floorf(_flipLayer.frame.size.height/2))];
    
    // Bottom
    [self setBottomFaceLayer:[[RMYGradientOverlayLayer alloc] initWithStyle:RMYGradientOverlayLayerTypeFace
                                                                   segment:RMYGradientOverlayLayerSegmentBottom]];
    
    [_bottomFaceLayer setFrame:CGRectMake(0., floorf(_flipLayer.frame.size.height / 2), _flipLayer.frame.size.width, floorf(_flipLayer.frame.size.height/2))];
    
    // Tick layer
    [self setTickLayer:[[RMYDoubleSidedLayer alloc] init]];
    
    [_tickLayer setAnchorPoint:CGPointMake(1., 1.)];
    [_tickLayer setFrame:CGRectMake(0., 0., _flipLayer.frame.size.width, floorf(_flipLayer.frame.size.height/2))];
    [_tickLayer setZPosition:1.]; // Above the other ones
    
    [_tickLayer setFrontLayer:[[RMYGradientOverlayLayer alloc] initWithStyle:RMYGradientOverlayLayerTypeTick
                                                                    segment:RMYGradientOverlayLayerSegmentTop]];
    
    [_tickLayer setBackLayer:[[RMYGradientOverlayLayer alloc] initWithStyle:RMYGradientOverlayLayerTypeTick
                                                                   segment:RMYGradientOverlayLayerSegmentBottom]];
    
    
    // Images
    if (direction == RMYFoldViewTickDirectionDown) {
        [_topFaceLayer setContents:(__bridge id)backImage.CGImage];
        [_bottomFaceLayer setContents:(__bridge id)frontImage.CGImage];
        [_tickLayer.frontLayer setContents:(__bridge id)frontImage.CGImage];
        [_tickLayer.backLayer setContents:(__bridge id)backImage.CGImage];
        
        [_topFaceLayer setGradientOpacity:1.];
        
        [_tickLayer setTransform:CATransform3DIdentity];
    }
    else if (direction == RMYFoldViewTickDirectionUp) {
        [_topFaceLayer setContents:(__bridge id)frontImage.CGImage];
        [_bottomFaceLayer setContents:(__bridge id)backImage.CGImage];
        [_tickLayer.frontLayer setContents:(__bridge id)backImage.CGImage];
        [_tickLayer.backLayer setContents:(__bridge id)frontImage.CGImage];
        
        [_bottomFaceLayer setGradientOpacity:1.];
        
        [_tickLayer setTransform:CATransform3DMakeRotation(-M_PI, 1., 0., 0.)];
    }
    
    // Add layers
    [_flipLayer addSublayer:_topFaceLayer];
    [_flipLayer addSublayer:_bottomFaceLayer];
    [_flipLayer addSublayer:_tickLayer];
}
- (void)_initializePan:(UIPanGestureRecognizer *)pan  direction:(RMYFoldViewTickDirection) direction{
    [self setFlipLayer:[CALayer layer]];
    [_flipLayer setFrame:self.layer.bounds];
    
    CATransform3D perspective = CATransform3DIdentity;
    float zDistanse = 400.;
    perspective.m34 = 1. / -zDistanse;
    [_flipLayer setSublayerTransform:perspective];
    
    [self.layer addSublayer:_flipLayer];
    
    UIImage *frontImage = [_frontView image];
    UIImage *backImage = [_backView image];
    
    // Face layers
    // Top
    [self setTopFaceLayer:[[RMYGradientOverlayLayer alloc] initWithStyle:RMYGradientOverlayLayerTypeFace
                                                                segment:RMYGradientOverlayLayerSegmentTop]];
    
    [_topFaceLayer setFrame:CGRectMake(0., 0., _flipLayer.frame.size.width, floorf(_flipLayer.frame.size.height/2))];
    
    // Bottom
    [self setBottomFaceLayer:[[RMYGradientOverlayLayer alloc] initWithStyle:RMYGradientOverlayLayerTypeFace
                                                                   segment:RMYGradientOverlayLayerSegmentBottom]];
    
    [_bottomFaceLayer setFrame:CGRectMake(0., floorf(_flipLayer.frame.size.height / 2), _flipLayer.frame.size.width, floorf(_flipLayer.frame.size.height/2))];
    
    // Tick layer
    [self setTickLayer:[[RMYDoubleSidedLayer alloc] init]];
    
    [_tickLayer setAnchorPoint:CGPointMake(1., 1.)];
    [_tickLayer setFrame:CGRectMake(0., 0., _flipLayer.frame.size.width, floorf(_flipLayer.frame.size.height/2))];
    [_tickLayer setZPosition:1.]; // Above the other ones
    
    [_tickLayer setFrontLayer:[[RMYGradientOverlayLayer alloc] initWithStyle:RMYGradientOverlayLayerTypeTick
                                                                    segment:RMYGradientOverlayLayerSegmentTop]];
    
    [_tickLayer setBackLayer:[[RMYGradientOverlayLayer alloc] initWithStyle:RMYGradientOverlayLayerTypeTick
                                                                   segment:RMYGradientOverlayLayerSegmentBottom]];
    
    CGPoint transP = [pan translationInView:pan.view];
    //让上部图片开始旋转
    CGFloat angle = transP.y * M_PI / 200;

    //近大远小效果
    CATransform3D transform = CATransform3DIdentity;
    //眼睛离屏幕的距离(透视效果)
    transform.m34 = -1 / 300.0;

    // Images
    if (direction == RMYFoldViewTickDirectionDown) {
        [_topFaceLayer setContents:(__bridge id)backImage.CGImage];
        [_bottomFaceLayer setContents:(__bridge id)frontImage.CGImage];
        [_tickLayer.frontLayer setContents:(__bridge id)frontImage.CGImage];
        [_tickLayer.backLayer setContents:(__bridge id)backImage.CGImage];
        
        [_topFaceLayer setGradientOpacity:transP.y * 1 / 200.0];
        
//        [_tickLayer setTransform:CATransform3DIdentity];
    }
    else if (direction == RMYFoldViewTickDirectionUp) {
        [_topFaceLayer setContents:(__bridge id)frontImage.CGImage];
        [_bottomFaceLayer setContents:(__bridge id)backImage.CGImage];
        [_tickLayer.frontLayer setContents:(__bridge id)backImage.CGImage];
        [_tickLayer.backLayer setContents:(__bridge id)frontImage.CGImage];
        
        [_bottomFaceLayer setGradientOpacity:transP.y * 1 / 200.0];
        
//        [_tickLayer setTransform:CATransform3DMakeRotation(-M_PI, 1., 0., 0.)];
    }
   _tickLayer.transform = CATransform3DRotate(transform, -angle, 1, 0, 0);
    // Add layers
    [_flipLayer addSublayer:_topFaceLayer];
    [_flipLayer addSublayer:_bottomFaceLayer];
    [_flipLayer addSublayer:_tickLayer];
}
- (void)_finalizeTick:(void (^)(void))completion {
    UIView *frontView = self.frontView;
    [self setFrontView:self.backView];
    [self setBackView:frontView];
    
    if (completion)
        completion();
    
    _flags.ticking = NO;
}

- (void)_pan:(UIPanGestureRecognizer *)gestureRecognizer {
    if (self.allowedPanDirections == RMYFoldViewAllowedPanDirectionNone)
        return;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
        _initialPanPosition = [gestureRecognizer locationInView:self];
    
    _lastPanPosition = [gestureRecognizer locationInView:self];
    
    // Start
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged && !_flags.panning) {
        // Down
        if (self.allowedPanDirections & RMYFoldViewAllowedPanDirectionDown && _initialPanPosition.y < _lastPanPosition.y) {
            NSLog(@"Start down");
            _panningDirection = RMYFoldViewTickDirectionDown;
            _flags.panning = YES;
            [self setFlipLayer:[CALayer layer]];
            [_flipLayer setFrame:self.layer.bounds];
            
            
        }
        // Up
        if (self.allowedPanDirections & RMYFoldViewAllowedPanDirectionUp && _initialPanPosition.y > _lastPanPosition.y) {
            NSLog(@"Start up");
            _panningDirection = RMYFoldViewTickDirectionUp;
            _flags.panning = YES;
            [self setFlipLayer:[CALayer layer]];
            [_flipLayer setFrame:self.layer.bounds];
        }
        
        return;
    }
    
    // Pan
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged && _flags.panning) {
        // Nop
        if (!(_panningDirection == RMYFoldViewTickDirectionDown && _initialPanPosition.y >= _lastPanPosition.y) &&
            !(_panningDirection == RMYFoldViewTickDirectionUp && _initialPanPosition.y <= _lastPanPosition.y)) {
            RMYFoldViewTickDirection direction = _panningDirection;
            [self _initializePan:gestureRecognizer direction:direction];
            NSLog(@"Pan!");
        }
    }
    
    // End
    if ((gestureRecognizer.state == UIGestureRecognizerStateCancelled || gestureRecognizer.state == UIGestureRecognizerStateEnded)
        && _flags.panning) {
        NSLog(@"End");
//        [self _initializeTick:_panningDirection];
        RMYFoldViewTickDirection direction = _panningDirection;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, .01 * NSEC_PER_SEC); // WTF!
//        dispatch_after(0, dispatch_get_main_queue(), ^(void){
//            [CATransaction begin];
//            [CATransaction setAnimationDuration:1];
//            
//            [CATransaction setCompletionBlock:^{
//                [_flipLayer removeFromSuperlayer], _flipLayer = nil;
//                [_topFaceLayer removeFromSuperlayer], _topFaceLayer = nil;
//                [_bottomFaceLayer removeFromSuperlayer], _bottomFaceLayer = nil;
//                [_tickLayer removeFromSuperlayer], _tickLayer = nil;
//
//                [self _finalizeTick:nil];
//            }];
//            
//            CGFloat angle = (M_PI) * (1-direction);
//            _tickLayer.transform = CATransform3DMakeRotation(angle, 1., 0., 0.);
//            
//            _topFaceLayer.gradientOpacity = direction;
//            _bottomFaceLayer.gradientOpacity = 1. - direction;
//            
//            ((RMYGradientOverlayLayer*)_tickLayer.frontLayer).gradientOpacity = 1. - direction;
//            ((RMYGradientOverlayLayer*)_tickLayer.backLayer).gradientOpacity = direction;
//            
//            [CATransaction commit];
//        });
        
        _flags.panning = NO;
    }
}

- (CGPoint)_invalidPanPosition {
    return CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX);
}

#pragma mark - Public

- (void)tick:(RMYFoldViewTickDirection)direction animated:(BOOL)animated completion:(void (^)(void))completion {
    if (_flags.ticking || !_frontView || !_backView)
        return;
    _flags.ticking = YES;
    
    if (!animated) {
        [self _finalizeTick:completion];
        return;
    }
    
    [self _initializeTick:direction];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, .01 * NSEC_PER_SEC); // WTF!
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [CATransaction begin];
        [CATransaction setAnimationDuration:_duration];
        
        [CATransaction setCompletionBlock:^{
            [_flipLayer removeFromSuperlayer], _flipLayer = nil;
            [_topFaceLayer removeFromSuperlayer], _topFaceLayer = nil;
            [_bottomFaceLayer removeFromSuperlayer], _bottomFaceLayer = nil;
            [_tickLayer removeFromSuperlayer], _tickLayer = nil;

            [self _finalizeTick:completion];
        }];
        
        CGFloat angle = (M_PI) * (1-direction);
        _tickLayer.transform = CATransform3DMakeRotation(angle, 1., 0., 0.);
        
        _topFaceLayer.gradientOpacity = direction;
        _bottomFaceLayer.gradientOpacity = 1. - direction;
        
        ((RMYGradientOverlayLayer*)_tickLayer.frontLayer).gradientOpacity = 1. - direction;
        ((RMYGradientOverlayLayer*)_tickLayer.backLayer).gradientOpacity = direction;
        
        [CATransaction commit];
    });

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
