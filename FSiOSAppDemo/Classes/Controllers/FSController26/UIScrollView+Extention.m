//
//  UIScrollView+Extention.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "UIScrollView+Extention.h"
#import <objc/runtime.h>


@implementation UIScrollView (Extention)

- (void)setFs_refreshHeader:(UIView *)fs_refreshHeader
{
    UIView *oldHeader = self.fs_refreshHeader;
 
    if ([oldHeader isEqual:fs_refreshHeader]) {
        return;
    }
    
    [oldHeader removeFromSuperview];
    
    objc_setAssociatedObject(self, @selector(fs_refreshHeader), fs_refreshHeader, OBJC_ASSOCIATION_ASSIGN);
    
    [self insertSubview:fs_refreshHeader atIndex:0];
}

- (UIView *)fs_refreshHeader
{
    UIView *header = objc_getAssociatedObject(self, @selector(fs_refreshHeader));
    
    return header;
}


@end
