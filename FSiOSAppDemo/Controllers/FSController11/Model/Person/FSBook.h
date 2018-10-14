//
//  FSBook.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/12.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSBaseData.h"

@interface FSBook : FSBaseData

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *isbn;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) int pageCount;

@end
