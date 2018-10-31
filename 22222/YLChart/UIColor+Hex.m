//
//  UIColor+Hex.m
//  BaiduPlace
//
//  Created by Neusoft on 11-12-5.
//  Copyright (c) 2011 Neusoft. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(uint) hex {
    
    int red, green, blue, alpha;
    blue = hex & 0x000000FF;
    green = ((hex & 0x0000FF00) >> 8);
    red = ((hex & 0x00FF0000) >> 16);
    alpha = ((hex & 0xFF000000) >> 24);
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.f];
}

+ (UIColor *)colorWithHex:(int)hex withAlpha:(CGFloat)alpha {
    CGFloat r = ((hex & 0xFF0000) >> 16) / 255.0;
    CGFloat g = ((hex & 0x00FF00) >> 8 ) / 255.0;
    CGFloat b = ((hex & 0x0000FF)      ) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

@end
