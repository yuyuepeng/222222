//
//  HXFCalendarCell.m
//  HXFCalendar
//
//  Created by 玉岳鹏 on 2018/10/8.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "HXFCalendarCell.h"

@interface HXFCalendarCell()

@property(nonatomic, strong) UILabel *label;

@property(nonatomic, strong) UIImageView *imageView;

@end


@implementation HXFCalendarCell
- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [_imageView setImage:[UIImage imageNamed:@"calendarImage"]];
    }
    return _imageView;
}
- (UILabel *)label {
    if (_label == nil) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        _label.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    }
    return _label;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.label];
        [self addSubview:self.imageView];
    }
    return self;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.label.text = title;
}
- (void)setCalendarTitleColor:(UIColor *)calendarTitleColor {
    _calendarTitleColor = calendarTitleColor;
    _label.textColor = calendarTitleColor;
}
- (void)setIsDaka:(BOOL)isDaka {
    _isDaka = isDaka;
    if (isDaka) {
        self.imageView.hidden = false;
        self.label.hidden = YES;
    }else {
        self.imageView.hidden = YES;
        self.label.hidden = false;
    }
}
@end
