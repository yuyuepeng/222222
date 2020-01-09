//
//  RMYVideoDownLoadCell.m
//  22222
//
//  Created by 王国良 on 2020/1/9.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import "RMYVideoDownLoadCell.h"
@interface RMYVideoDownLoadCell()

/// 下边的slider
@property(nonatomic, strong) UIView *backSlider;

/// 上边的slider
@property(nonatomic, strong) UIView *frontSlider;

@end

@implementation RMYVideoDownLoadCell {
    CGFloat sliderWidth;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    sliderWidth = mainWidth - 40;
    if (self) {
        [self.contentView addSubview:self.backSlider];
        [self.contentView addSubview:self.frontSlider];
    }
    return self;
}
- (UIView *)backSlider {
    if (_backSlider == nil) {
        _backSlider = [[UIView alloc] initWithFrame:CGRectMake(20, 20, mainWidth - 40, 10)];
        _backSlider.backgroundColor = [UIColor lightGrayColor];
    }
    return _backSlider;
}

- (UIView *)frontSlider {
    if (_frontSlider == nil) {
        _frontSlider = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 0, 10)];
        _frontSlider.backgroundColor = [UIColor blueColor];
    }
    return _frontSlider;
}
- (void)setProgress:(float)progress {
    _progress = progress;
    _frontSlider.width = sliderWidth/100.0f * progress;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
