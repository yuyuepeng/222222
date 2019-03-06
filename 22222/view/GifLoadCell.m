//
//  GifLoadCell.m
//  22222
//
//  Created by 玉岳鹏 on 2019/1/14.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "GifLoadCell.h"

@interface GifLoadCell()

@property(nonatomic, strong) UIWebView *webView;


@end

@implementation GifLoadCell
- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, mainHeight)];
        _webView.centerX = mainWidth/2;

        _webView.scrollView.bounces = NO;
        //设置webview背景透明，能看到gif的透明层
//        _webView.backgroundColor = [UIColor blackColor];
        _webView.opaque = NO;
    }
    return _webView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    return self;
}
- (void)createViews {
    [self addSubview:self.webView];
}
- (void)setGifPath:(NSString *)gifPath {
//    NSURL *url = [NSURL fileURLWithPath:gifPath];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_webView loadRequest:request];
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:gifPath ofType:@"gif"]];
    [_webView loadData:gif MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:nil];

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
