//
//  List.h
//  22222
//
//  Created by 玉岳鹏 on 2019/5/31.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ELEMENT_NOT_FOUND -1
NS_ASSUME_NONNULL_BEGIN

@interface List : NSObject

- (void)clear;

- (NSInteger)size;

- (BOOL)isEmpty;

- (BOOL)containsElement:(id)element;

- (void)addElement:(id)element;

- (id)getWithIndex:(NSInteger)index;

- (id)setElement:(id)element index:(NSInteger)index;

- (void)addElement:(id)element index:(NSInteger)index;

- (id)removeWithIndex:(NSInteger)index;

- (NSInteger)indexOfElement:(id)element;

@end

NS_ASSUME_NONNULL_END
