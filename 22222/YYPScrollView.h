//
//  YYPScrollView.h
//  111111
//
//  Created by 玉岳鹏 on 2018/7/5.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYPScrollView : UIScrollView

/**
 单张图片的大小
 */
@property(nonatomic, assign) CGSize imageSize;

@property(nonatomic, assign) CGFloat separatorWidth;

- (void)customImageViewWithImageUrls:(NSArray <NSString *>*)imageUrls;

@end
