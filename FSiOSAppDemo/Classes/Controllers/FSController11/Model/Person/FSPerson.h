//
//  FSPerson.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/12.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSBaseData.h"
#import "FSBook.h"
#import "FSCar.h"
#import "FSDog.h"


@interface FSPerson : FSBaseData

@property (nonatomic, assign) NSInteger rowId;

/// 身份证号
@property (nonatomic, strong) NSString *idNum;

/// YYYYMMdd
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) int age;

@property (nonatomic, assign) float height;

@property (nonatomic, strong) FSCar *car;

@property (nonatomic, strong) FSDog *dog;

@property (nonatomic, strong) NSArray<FSBook *> *books;


@end
