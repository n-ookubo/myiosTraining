//
//  MyView.m
//  CustomUIViewSample
//
//  Created by 大久保直昭 on 2015/07/10.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "MyView.h"

@implementation MyView
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGColorRef fillColor = CGColorRetain([[UIColor whiteColor] CGColor]);
    CGContextSetFillColorWithColor(context, fillColor);
    if (w > 2 && h > 2){
        CGContextFillEllipseInRect(context, CGRectMake(1, 1, w - 2, h - 2));
    } else {
        CGContextFillEllipseInRect(context, CGRectMake(0, 0, w, h));
    }
    CGColorRelease(fillColor);
}

@end
