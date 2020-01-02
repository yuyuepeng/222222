//
//  NewsPage.m
//  22222
//
//  Created by 扶摇先生 on 2019/12/24.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "NewsPage.h"

@interface NewsPage()

@property(nonatomic, strong) UILabel *label;

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation NewsPage {
    NSArray *array;
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier];
    if (self) {
        [self buildViews];
        array = @[@"看到这个题目，我简单粗暴的想起了三层for循环，需要考虑的是三层for循环里的数，每层的数都不能是一样的，于是写出了这样的方法。",@"但是这样的话只是取出来的数虽然无重复，但是每次取出来的数是有顺序的，可能每次取出的都是第0，1，2个元素",@"但是有可能第一层循环取出的是0 也可能是1或者2，这样的话，循环的次数就有没必要的增加，实际上是A(3,N)和C(3,N)的区别，于是优化如下",@"但是三层for循环时间复杂度还是比较大，从网上找了比较好的优化方法，思路是先将数组排序，外层遍历和上边的方法一样，",@"只遍历count -2次，然后前边的数往后赶，后边的数往前赶，利用双指针遍历，时间复杂度能减少一半，"];
    }
    return self;
}
- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, mainWidth, self.height/2)];
        _label.numberOfLines = 0;
        _label.font = [UIFont systemFontOfSize:18];
    }
    return _label;
}
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height/2, mainWidth, self.height/2)];
    }
    return _imageView;
}
- (void)buildViews {
    [self addSubview:self.label];
    [self addSubview:self.imageView];
}
- (void)setIndex:(NSInteger)index {
    
    [_imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"img%ld.jpg",index + 1]]];
    _label.text = array[index];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
