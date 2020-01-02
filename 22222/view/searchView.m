//
//  searchView.m
//  22222
//
//  Created by 扶摇先生 on 2020/1/2.
//  Copyright © 2020 玉岳鹏. All rights reserved.
//

#import "searchView.h"

@interface searchView()<UITextFieldDelegate>

@property(nonatomic, strong) UITextField *searchTextfield;

@end

@implementation searchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
        
    }
    return self;
}
- (UITextField *)searchTextfield {
    if (_searchTextfield == nil) {
        _searchTextfield = [[UITextField alloc] initWithFrame:CGRectMake(44, 0, mainWidth - 88, 44)];
        _searchTextfield.textAlignment = NSTextAlignmentLeft;
        _searchTextfield.placeholder = @"请输入您想搜索的内容";
        _searchTextfield.delegate = self;
    }
    return _searchTextfield;
}
- (void)createViews {
    [self addSubview:self.searchTextfield];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(clickEnter:)]) {
        [self.delegate clickEnter:@{@"textField":self.searchTextfield}];
    }
    return YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
