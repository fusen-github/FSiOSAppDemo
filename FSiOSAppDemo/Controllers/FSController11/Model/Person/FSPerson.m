//
//  FSPerson.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/12.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSPerson.h"

@implementation FSPerson

/*
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
 */

+ (instancetype)dataWithDict:(NSDictionary *)dict
{
    if (![dict isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    
    FSPerson *person = [[FSPerson alloc] init];
    
    person.rowId = [[dict objectForKey:@"row_id"] integerValue];
    
    person.idNum = [dict objectForKey:@"id_num"];
    
    person.name = [dict objectForKey:@"name"];
    
    person.age = [[dict objectForKey:@"age"] intValue];
    
    person.height = [[dict objectForKey:@"height"] floatValue];
    
    NSDictionary *car_json = [dict objectForKey:@"car"];
    
    person.car = [FSCar dataWithDict:car_json];
    
    NSDictionary *dog_json = [dict objectForKey:@"dog"];
    
    person.dog = [FSDog dataWithDict:dog_json];
    
    NSMutableArray *tmpBooks = [NSMutableArray array];
    
    NSArray *bookJsons = [dict objectForKey:@"books"];
    
    for (NSDictionary *book_json in bookJsons)
    {
        FSBook *book = [FSBook dataWithDict:book_json];
        
        if (book)
        {
            [tmpBooks addObject:book];
        }
    }
    
    person.books = tmpBooks;
    
    return person;
}


@end
