//
//  NSString+JSON.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)

- (id)toJsonObject
{
    NSError *error = nil;
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    if (jsonObj && error == nil)
    {
        return jsonObj;
    }
    
    return nil;
}

@end
