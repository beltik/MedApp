//
//  UIColor+JPExtras.m
//  moscowGuide
//
//  Created by Necrosoft on 24/07/14.
//  Copyright (c) 2014 Necrosoft. All rights reserved.
//

#import "UIColor+JPExtras.h"

@implementation UIColor (JPExtras)

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha {
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

@end
