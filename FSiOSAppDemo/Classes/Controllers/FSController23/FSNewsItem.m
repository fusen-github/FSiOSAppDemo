//
//  FSNewsItem.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/18.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSNewsItem.h"

@implementation FSNewsItem

+ (instancetype)itemWithJson:(NSDictionary *)json
{
    FSNewsItem *item = [[FSNewsItem alloc] init];
    
    item.imageUrl = [json objectForKey:@"icon"];
    
    item.newsContent = [json objectForKey:@"text_content"];
    
    item.title = [json objectForKey:@"title"];
    
    return item;
}

@end
