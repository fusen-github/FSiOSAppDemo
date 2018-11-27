//
//  FS10ColletionItem.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, enmPasType)
{
    /// 未调查
    enmPasTypeNone      = 0,
    /// 1 楼栋门牌
    enmPasTypeValue1    = 1,
    /// 2 楼门门牌
    enmPasTypeValue2    = 2,
    /// 3 地址门牌
    enmPasTypeValue3    = 3,
};



@interface FS10ColletionItem : NSObject

@property (nonatomic, readonly) NSString *title;

- (instancetype)initWithTitle:(NSString *)title;

@end
