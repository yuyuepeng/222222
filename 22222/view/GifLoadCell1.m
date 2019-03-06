//
//  GifLoadCell1.m
//  22222
//
//  Created by 玉岳鹏 on 2019/1/23.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "GifLoadCell1.h"
#import <SDWebImage.h>
#import <UIImage+GIF.h>
@interface GifLoadCell1 ()

@property(nonatomic, strong) UIImageView *gifShower;

@end

@implementation GifLoadCell1

- (UIImageView *)gifShower {
    if (_gifShower == nil) {
        _gifShower = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 335, 110)];
        _gifShower.centerX = mainWidth/2;
//        NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"效果图" ofType:@"gif"]];
//        _webView.userInteractionEnabled = NO;
//        [_webView loadData:gif MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:nil];
//        //设置webview背景透明，能看到gif的透明层
//        _webView.backgroundColor = [UIColor blackColor];
//        _webView.opaque = NO;
    }
    return _gifShower;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    return self;
}
- (void)createViews {
    [self addSubview:self.gifShower];
}
- (void)setGifPath:(NSString *)gifPath {
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:gifPath ofType:@"gif"];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    _gifShower.backgroundColor = [UIColor clearColor];
//    _gifShowe
    _gifShower.image = [UIImage sd_imageWithData:imageData];
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
