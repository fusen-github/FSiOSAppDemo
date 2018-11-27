//
//  UIView+Extention.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "UIView+Extention.h"
#import <objc/runtime.h>


@implementation UIView (Extention)

- (void)setFs_userInfo:(id)fs_userInfo
{
    objc_setAssociatedObject(self, @selector(fs_userInfo), fs_userInfo, OBJC_ASSOCIATION_ASSIGN);
}

- (id)fs_userInfo
{
    return objc_getAssociatedObject(self, @selector(fs_userInfo));
}

@end
