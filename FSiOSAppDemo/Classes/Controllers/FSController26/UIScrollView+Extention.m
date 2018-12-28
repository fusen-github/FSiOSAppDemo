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

//+ (void)load
//{
//    Method m1 = class_getInstanceMethod([self class], @selector(layoutSubviews));
//
//    Method m2 = class_getInstanceMethod([self class], @selector(extention_layoutSubviews));
//
//    method_exchangeImplementations(m1, m2);
//}


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


//- (void)extention_layoutSubviews
//{
//    [self extention_layoutSubviews];
//
//    CGFloat width = self.fs_refreshHeader.bounds.size.width;
//
//    CGFloat selfWidth = self.bounds.size.width;
//
//    if (selfWidth != width)
//    {
//        NSLog(@"来了");
//
//        self.fs_refreshHeader.bounds = CGRectMake(0, 0, selfWidth, 54);
//    }
//}

@end
