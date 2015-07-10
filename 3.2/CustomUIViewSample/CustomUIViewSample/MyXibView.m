//
//  MyXibView.m
//  CustomUIViewSample
//
//  Created by 大久保直昭 on 2015/07/10.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "MyXibView.h"

@implementation MyXibView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    
    NSArray *topLevelViews = [[NSBundle mainBundle] loadNibNamed:@"MyXibView" owner:self options:nil];
    self.topView = topLevelViews[0];
    [self addSubview:_topView];
}

- (void) layoutSubviews
{
    self.topView.frame = self.bounds;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
