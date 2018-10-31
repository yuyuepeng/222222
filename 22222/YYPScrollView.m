//
//  YYPScrollView.m
//  111111
//
//  Created by 玉岳鹏 on 2018/7/5.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "YYPScrollView.h"

@interface YYPScrollView()


@end

@implementation YYPScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)setImageSize:(CGSize)imageSize {
    _imageSize = imageSize;
}
- (void)setSeparatorWidth:(CGFloat)separatorWidth {
    _separatorWidth = separatorWidth;
}
- (void)customImageViewWithImageUrls:(NSArray<NSString *> *)imageUrls {
    [self removeImageViews];
    self.contentSize = CGSizeMake(imageUrls.count * self.imageSize.width + self.separatorWidth * (imageUrls.count + 1), self.imageSize.height);
    NSInteger i = 0;
    for (NSString *imageUrl in imageUrls) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.separatorWidth + (self.imageSize.width + self.separatorWidth) * i, 0, self.imageSize.width, self.imageSize.height)];
        NSLog(@"%@",imageUrl);
        imageView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0f green:arc4random()%255/255.0f blue:arc4random()%255/255.0f alpha:1];
        [imageView setImage:[UIImage imageNamed:imageUrl]];
        [self addSubview: imageView];
        i ++;
    }
    
}
- (void)removeImageViews {
    for (UIImageView *imageView in self.subviews) {
        [imageView removeFromSuperview];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
