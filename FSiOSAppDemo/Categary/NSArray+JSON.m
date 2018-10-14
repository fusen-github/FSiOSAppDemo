//
//  NSArray+JSON.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "NSArray+JSON.h"

@implementation NSArray (JSON)

- (NSString *)toJsonString
{
    NSData *data = [self toJsonData];
    
    NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return json;
}

- (NSData *)toJsonData
{
    NSError *error = nil;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if (data && error == nil)
    {
        return data;
    }
    
    return nil;
}

@end
