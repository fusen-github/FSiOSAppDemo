//
//  FSNewsItem.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/18.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSNewsItem : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *newsContent;

@property (nonatomic, strong) NSString *imageUrl;

+ (instancetype)itemWithJson:(NSDictionary *)json;

@end
