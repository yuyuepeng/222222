//
//  LinkList.h
//  22222
//
//  Created by 扶摇先生 on 2019/6/3.
//  Copyright © 2019年 玉岳鹏. All rights reserved.
//

#import "AbstractList.h"
NS_ASSUME_NONNULL_BEGIN
@interface Node : NSObject

@property(nonatomic, strong) Node *next;

@property(nonatomic, strong) id element;

- (instancetype)initWithElement:(id)element next:(Node *)next;

@end


@interface LinkList : AbstractList

@end

NS_ASSUME_NONNULL_END
