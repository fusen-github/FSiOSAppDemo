//
//  FSImageItem.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/26.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSImageItem : NSObject

- (instancetype)initWithThumb:(UIImage *)thumn path:(NSString *)path;

@property (nonatomic, strong) UIImage *thumbImage;

@property (nonatomic, copy) NSString *imagePath;

@end
