//
//  AmyView.m
//  22222
//
//  Created by 玉岳鹏 on 2019/9/19.
//  Copyright © 2019 玉岳鹏. All rights reserved.
//

#import "AmyView.h"

@implementation AmyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)dealloc {
    NSLog(@"AmyView已经销毁");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"wodexiaobaobao" object:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
