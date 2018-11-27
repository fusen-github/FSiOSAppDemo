//
//  NSData+JSON.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/14.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

- (id)toJsonObject
{
    NSError *error = nil;
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    
    if (error)
    {
        return nil;
    }
    
    return jsonObj;
}

@end
