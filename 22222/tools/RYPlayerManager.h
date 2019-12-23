//
//  RYPlayerManager.h
//  22222
//
//  Created by 扶摇先生 on 2019/12/11.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RYPlayerManager : NSObject

+ (instancetype)sharePlayerManager;

- (void)playVideoWithUrl:(NSString *)videoUrl;

@end

NS_ASSUME_NONNULL_END
