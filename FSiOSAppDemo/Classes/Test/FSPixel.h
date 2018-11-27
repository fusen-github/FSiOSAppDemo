//
//  FSPixel.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/17.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSPixel : NSObject

/**
 red 的8位二进制
 */
@property (nonatomic, assign) NSString *redBinary;

/**
 green 的8位二进制
 */
@property (nonatomic, assign) NSString *greenBinary;

/**
 blue 的8位二进制
 */
@property (nonatomic, assign) NSString *blueBinary;

@property (nonatomic, assign) CGFloat alpha;

@end
