//
//  main.m
//  JsonSample
//
//  Created by 大久保直昭 on 2015/07/20.
//  Copyright (c) 2015年 大久保直昭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HogeObject : NSObject
@property (nonatomic) NSString *string;
@property (nonatomic) NSNumber *number;
@property (nonatomic) NSArray *array;
@property (nonatomic) NSDictionary *dictionary;

- (NSDictionary *)dictionary;
@end

@implementation HogeObject
- (NSDictionary *)dictionary
{
    return @{@"string" : _string, @"number" : _number, @"array" : _array, @"dictionary" : _dictionary};
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        HogeObject *hoge = [[HogeObject alloc] init];
        hoge.string = @"hogeString";
        hoge.number = @18;
        hoge.array = @[@"foo", @"bar", @1, @2, @3];
        hoge.dictionary = @{@"str" : @"hoge", @"number" : @12345};
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:[hoge dictionary] options:0 error:nil];
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
    }
    return 0;
}
