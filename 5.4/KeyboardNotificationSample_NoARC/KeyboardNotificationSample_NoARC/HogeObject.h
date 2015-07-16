//
//  HogeObject.h
//  KeyboardNotificationSample_NoARC
//
//  Created by 大久保直昭 on 2015/07/16.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HogeObject : NSObject
@property (copy, nonatomic) NSString *text;

- (instancetype)initWithString:(NSString *)str;
@end
