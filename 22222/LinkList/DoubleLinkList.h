//
//  DoubleLinkList.h
//  22222
//
//  Created by 玉岳鹏 on 2019/6/14.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "AbstractList.h"

NS_ASSUME_NONNULL_BEGIN
@interface DoubleNode : NSObject

@property(nonatomic, strong) DoubleNode *next;

@property(nonatomic, strong) DoubleNode *prev;

@property(nonatomic, strong) id element;

- (instancetype)initWithElement:(id)element prev:(DoubleNode *)prev next:(DoubleNode *)next;


@end

@interface DoubleLinkList : AbstractList

@end

NS_ASSUME_NONNULL_END
