//
//  Person.h
//  22222
//
//  Created by 玉岳鹏 on 2019/6/10.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *age;

//- (void)log1;
//- (void)log2;
- (void)showObjectInfo;

- (void)sayhahahaToAmy;

+ (void)sayHelloToAmy;
@end

NS_ASSUME_NONNULL_END
