//
//  HogeObject.m
//  KeyboardNotificationSample_NoARC
//
//  Created by 大久保直昭 on 2015/07/16.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import "HogeObject.h"

@interface HogeObject  ()
@end

@implementation HogeObject
- (instancetype)initWithString:(NSString *)str
{
    self = [super init];
    if (self) {
        self.text = str;
    }
    return self;
}

- (void)dealloc
{
    [self.text release];
    [super dealloc];
}
@end
