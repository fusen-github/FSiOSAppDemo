//
//  FSBaseData.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/12.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSBaseData : NSObject

+ (instancetype)dataWithDict:(NSDictionary *)dict;

- (NSDictionary *)toDictionary;

@end
