//
//  FSQuartzView.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/29.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSQuartzView.h"

@implementation FSQuartzView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setNeedsDisplayInRect:CGRectZero];
}

- (void)drawRect:(CGRect)rect
{
    
}

@end
