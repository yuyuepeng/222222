//
//  RMYMaskCell.m
//  22222
//
//  Created by 扶摇先生 on 2019/11/27.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "RMYMaskCell.h"

@interface RMYMaskCell()

@property(nonatomic, strong) UILabel *innerLabel;

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation RMYMaskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.innerLabel];
        [self.contentView addSubview:self.titleLabel];
        [_innerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).with.offset(10);
            make.top.mas_equalTo(self.contentView).with.offset(10);
            make.width.mas_equalTo(200);
            make.bottom.mas_equalTo(self.contentView).with.offset(-10);
        }];
//        NSLayoutConstraint *layOut = [[NSLayoutConstraint alloc] init];
        
//        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.contentView).with.offset(10);
//            make.top.mas_equalTo(self.contentView).with.offset(10);
//            make.width.mas_equalTo(200);
//            make.bottom.mas_equalTo(self.contentView).with.offset(-10);
//        }];
    }
    return self;
}
- (UILabel *)innerLabel {
    if (_innerLabel == nil) {
        _innerLabel = [[UILabel alloc] init];
        _innerLabel.textColor = [UIColor whiteColor];
        _innerLabel.numberOfLines = 0;
        _innerLabel.font = [UIFont boldSystemFontOfSize:15];
        _innerLabel.backgroundColor = [UIColor blackColor];
        
    }
    return _innerLabel;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.backgroundColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (void)refreshText:(NSString *)text {
    _innerLabel.text = text;
    
//    [_innerLabel sizeToFit];
//    [_innerLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(200);
//    }];
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
