//
//  MyView.m
//  CustomUIViewSample
//
//  Created by 大久保直昭 on 2015/07/10.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "MyView.h"

@implementation MyView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeView];
    }
    return self;
}

- (void)initializeView
{
    //self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGColorRef fillColor = CGColorRetain([[UIColor whiteColor] CGColor]);
    CGContextSetFillColorWithColor(context, fillColor);
    CGContextFillEllipseInRect(context, CGRectMake(0, 0, w, h));
    CGColorRelease(fillColor);
}

@end
