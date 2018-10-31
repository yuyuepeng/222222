//
//  HXFPhoneNumView.m
//  22222
//
//  Created by 玉岳鹏 on 2018/10/17.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "HXFPhoneNumView.h"

@interface HXFPhoneNumView()<UITextFieldDelegate>

@property(nonatomic, strong) UITextField *tf;

@property(nonatomic, strong) UILabel *holderLabel;

@property(nonatomic, strong) UIView *blackLine;

@property(nonatomic, strong) UIView *redLine;

@end

@implementation HXFPhoneNumView {
    CGFloat singleLength;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    singleLength = mainWidth/750.0f;
    if (self) {
        //135
        [self addSubview:self.tf];
        [self addSubview:self.holderLabel];
        [self addSubview:self.blackLine];
        [self addSubview:self.redLine];
    }
    return self;
}
- (UITextField *)tf {
    if (_tf == nil) {
        _tf = [[UITextField alloc] initWithFrame:CGRectMake(60 * singleLength, 50 * singleLength, 630 * singleLength, 40 * singleLength)];
        _tf.delegate = self;
        _tf.textColor = RGB(50, 51, 60);
        _tf.textAlignment = NSTextAlignmentLeft;
        _tf.font = [UIFont systemFontOfSize:36 * singleLength];
    }
    return _tf;
}
- (UILabel *)holderLabel {
    if (_holderLabel == nil) {
        _holderLabel = [[UILabel alloc] initWithFrame:CGRectMake(60 * singleLength, 50 * singleLength, 150, 40 * singleLength)];
        _holderLabel.text = @"手机号";
        _holderLabel.textColor = RGB(50, 51, 60);
        _holderLabel.textAlignment = NSTextAlignmentLeft;
        _holderLabel.font = [UIFont systemFontOfSize:36 * singleLength];
    }
    return _holderLabel;
}
- (UIView *)blackLine {
    if (_blackLine == nil) {
        _blackLine = [[UIView alloc] initWithFrame:CGRectMake(60 * singleLength, 133 * singleLength, 630 * singleLength, 2 * singleLength)];
        _blackLine.backgroundColor = [self colorWithHexString:@"4A4A4A"];// [UIColor blackColor];
    }
    return _blackLine;
}
- (UIView *)redLine {
    if (_redLine == nil) {
        _redLine = [[UIView alloc] initWithFrame:CGRectMake(60 * singleLength, 133 * singleLength, 0, 2 * singleLength)];
        _redLine.backgroundColor = [self colorWithHexString:@"F73A3A"];
    }
    return _redLine;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    NSLog(@"Let's begin");
    [UIView animateWithDuration:0.5f animations:^{
        self.holderLabel.textColor = RGB(153, 154, 166);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.holderLabel.font = [UIFont systemFontOfSize:24 * self -> singleLength];
        });
        self.holderLabel.y = 0;
    }];
    [UIView animateWithDuration:0.4f animations:^{
        self.redLine.frame = CGRectMake(60 * self->singleLength, 133 *self-> singleLength, 630 * self->singleLength, 2 * self->singleLength);
    }];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        [UIView animateWithDuration:0.5f animations:^{
            self.holderLabel.textColor = RGB(50, 51, 60);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.holderLabel.font = [UIFont systemFontOfSize:36 * self -> singleLength];
            });
            self.holderLabel.y = 50 *self-> singleLength;
        }];
        
    }else {
        [UIView animateWithDuration:0.5f animations:^{
            self.holderLabel.textColor = RGB(153, 154, 166);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.holderLabel.font = [UIFont systemFontOfSize:24 * self -> singleLength];
            });
            self.holderLabel.y = 0;
        }];
    }
    [UIView animateWithDuration:0.4 animations:^{
        self.redLine.frame = CGRectMake(60 * self->singleLength, 133 * self->singleLength, 0, 2 * self-> singleLength);
    }];
    
    NSLog(@"Let's end");
}
- (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color alpha:1.0];
}

- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
