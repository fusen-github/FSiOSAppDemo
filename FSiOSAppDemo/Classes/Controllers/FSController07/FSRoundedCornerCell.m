//
//  FSRoundedCornerCell.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/16.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSRoundedCornerCell.h"

@implementation FSRoundedCornerCell


- (void)setFrame:(CGRect)frame
{
    UIInterfaceOrientation interfaceOritation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGFloat space = 0;
    
    if (interfaceOritation == UIInterfaceOrientationPortrait ||
        interfaceOritation == UIInterfaceOrientationPortraitUpsideDown)
    {
        space = 30;
    }
    else
    {
        space = 120;
    }
    
    CGFloat x = frame.origin.x;
    
    x = x + space;
    
    frame.origin.x = x;
    
    CGFloat width = frame.size.width;
    
    width -= 2 * space;
    
    frame.size.width = width;
    
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}


@end
