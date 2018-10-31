//
//  HXFTransverseTableViewCell.m
//  HeXinFound
//
//  Created by lishaopeng on 2018/7/5.
//  Copyright © 2018年 Dusk. All rights reserved.
//

#import "HXFTransverseTableViewCell.h"


@interface HXFTransverseTableViewCell ()

@property (nonatomic, weak) UIImageView *imageV;

@end

@implementation HXFTransverseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
        [self setBackgroundColor:[UIColor greenColor]];
        [self createView];
    }
    return self;
}

- (void)createView
{
    UIImageView *imageV = [[UIImageView alloc]init];
    self.imageV = imageV;
    [self addSubview:imageV];
}

- (void)layoutSubviews
{
    [self.imageV setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)fillCellImage:(UIImage *)image
{
    self.imageV.image = image;
}

- (void)clearCell
{
    self.imageV.image = [UIImage imageNamed:@""];
}

@end
