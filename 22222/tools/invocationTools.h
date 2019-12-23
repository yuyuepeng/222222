//
//  invocationTools.h
//  22222
//
//  Created by 扶摇先生 on 2019/11/29.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface invocationTools : NSObject

+ (void)callMethodWithPara:(NSDictionary *)para target:(id)target selector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
