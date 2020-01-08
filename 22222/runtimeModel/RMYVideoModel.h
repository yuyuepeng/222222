//
//  RMYVideoModel.h
//  22222
//
//  Created by 王国良 on 2020/1/8.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import "JKDBModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RMYVideoModel : JKDBModel

/// 沙盒路径
@property(nonatomic, copy) NSString *sandBoxPath;

/// videoid
@property(nonatomic, copy) NSString *vid;

@end

NS_ASSUME_NONNULL_END
