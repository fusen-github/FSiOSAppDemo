//
//  FSImageItem.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/26.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSImageItem.h"

@implementation FSImageItem

- (instancetype)initWithThumb:(UIImage *)thumn path:(NSString *)path
{
    if (self = [super init])
    {
        self.thumbImage = thumn;
        
        self.imagePath = path;
    }
    return self;
}

@end
