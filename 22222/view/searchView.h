//
//  searchView.h
//  22222
//
//  Created by 扶摇先生 on 2020/1/2.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol searchViewDelegate <NSObject>

- (void)clickEnter:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_BEGIN

@interface searchView : UIView

@property(nonatomic, weak) id <searchViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
