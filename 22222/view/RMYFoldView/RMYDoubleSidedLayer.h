//
//  RMYDoubleSidedLayer.h
//  22222
//
//  Created by 扶摇先生 on 2019/12/20.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface RMYDoubleSidedLayer : CATransformLayer

@property (nonatomic, retain) CALayer *frontLayer;
@property (nonatomic, retain) CALayer *backLayer;

@end

NS_ASSUME_NONNULL_END
