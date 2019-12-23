//
//  RMYGradientOverlayLayer.h
//  22222
//
//  Created by 扶摇先生 on 2019/12/20.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef enum {
    RMYGradientOverlayLayerTypeFace,
    RMYGradientOverlayLayerTypeTick
} RMYGradientOverlayLayerType;

typedef enum {
    RMYGradientOverlayLayerSegmentTop,
    RMYGradientOverlayLayerSegmentBottom
} RMYGradientOverlayLayerSegment;

NS_ASSUME_NONNULL_BEGIN

@interface RMYGradientOverlayLayer : CALayer

@property (nonatomic, readonly) RMYGradientOverlayLayerType type;
@property (nonatomic, readonly) RMYGradientOverlayLayerSegment segment;
@property (nonatomic) CGFloat gradientOpacity;

- (id)initWithStyle:(RMYGradientOverlayLayerType)type segment:(RMYGradientOverlayLayerSegment)segment;

@end

NS_ASSUME_NONNULL_END
