//
//  FSLayer.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/4.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSLayer.h"

@implementation FSLayer

- (id<CAAction>)actionForKey:(NSString *)event
{
    id action = [super actionForKey:event];
    
    return action;
}

+ (id<CAAction>)defaultActionForKey:(NSString *)event
{
    id action = [super defaultActionForKey:event];
    
    return action;
}

@end
