//
//  FSCar.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/12.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSBaseData.h"

@interface FSCar : FSBaseData

@property (nonatomic, strong) NSString *brand;

/// 座位
@property (nonatomic, assign) int seatCount;

@end
