//
//  FSRoleDBManager.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/12.
//  Copyright © 2018年 付森. All rights reserved.
//  角色

#import <Foundation/Foundation.h>
#import "FSPerson.h"


@interface FSRoleDBManager : NSObject

+ (instancetype)shareManager;

@end

@interface FSRoleDBManager (Person)

- (BOOL)insertPerson:(FSPerson *)person;

- (NSArray *)queryPersonBySql:(NSString *)sql;

@end

@interface FSRoleDBManager (Company)


@end
