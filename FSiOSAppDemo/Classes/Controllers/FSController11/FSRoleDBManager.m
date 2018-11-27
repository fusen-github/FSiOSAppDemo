//
//  FSRoleDBManager.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/12.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSRoleDBManager.h"
#import "FMDB.h"

@interface FSRoleDBManager ()
{
    FMDatabase *_database;
}

@end


@implementation FSRoleDBManager

+ (instancetype)shareManager
{
    static FSRoleDBManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    if (self = [super init])
    {
        NSString *library = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *path = [library stringByAppendingPathComponent:@"SenData"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:path])
        {
            NSError *error = nil;
            
            BOOL rst = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
            
            if (rst && !error)
            {
                return self;
            }
        }
        
        path = [path stringByAppendingPathComponent:@"role.sqlite"];
        
        _database = [FMDatabase databaseWithPath:path];
        
        NSString *sql = @"create table if not exists person ("
                         "row_id        integer  primary  key  autoincrement not null,"
                         "id_num        text   not  null  unique,"
                         "name          text   not  null,"
                         "age           integer,"
                         "height        real,"
                         "car           blob,"
                         "dog           blob,"
                         "books         blob"
                         ");";
        
        if ([_database open])
        {
            BOOL createTableRst = [_database executeUpdate:sql];
            
            if (createTableRst)
            {
                NSLog(@"person 创建成功");
            }
            else
            {
                NSLog(@"person 创建失败");
            }
            
            [_database close];
        }
    }
    return self;
}

@end

@implementation FSRoleDBManager (Person)

/*
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

/*
 NSString *sql = @"create table if not exists person ("
 "row_id        integer  primary  key  autoincrement not null,"
 "id_num        text   not  null  unique,"
 "name          text   not  null,"
 "age           integer,"
 "height        real,"
 "car           blob,"
 "dog           blob,"
 "books         blob"
 ");";
 */

- (BOOL)insertPerson:(FSPerson *)person
{
    BOOL rst = NO;
    
    if ([_database open])
    {
        NSString *sql = @"insert into person "
                         "(id_num, name, age, height, car, dog, books) values "
                         "(?, ?, ?, ?, ?, ?, ?)";
        
        NSMutableArray *values = [NSMutableArray array];
        
        /// id_num
        [values addObject:NilString(person.idNum)];
        
        /// name
        [values addObject:NilString(person.name)];
        
        /// age
        [values addObject:@(person.age)];
        
        /// height
        [values addObject:@(person.height)];
        
        {
            // car
            NSDictionary *car_dict = [person.car toDictionary];
            
            id jsonObj = [NSNull null];
            
            if ([car_dict isKindOfClass:[NSDictionary class]])
            {
                jsonObj = [car_dict toJsonData];
            }
            
            [values addObject:jsonObj];
        }
        
        {
            /// dog
            NSDictionary *dog_dict = [person.dog toDictionary];
            
            id jsonObj = [NSNull null];
            
            if ([dog_dict isKindOfClass:[NSDictionary class]])
            {
                jsonObj = [dog_dict toJsonData];
            }
            
            [values addObject:jsonObj];
        }
        
        {
            /// books
            NSMutableArray *book_jsons = [NSMutableArray array];
            
            for (FSBook *book in person.books)
            {
                if (![book isKindOfClass:[FSBook class]])
                {
                    continue;
                }
                
                NSString *b_json = [[book toDictionary] toJsonString];
                
                [book_jsons addObject:NilString(b_json)];
            }
            
            NSData *data = [book_jsons toJsonData];
            
            [values addObject:data];
        }
        
        rst = [_database executeUpdate:sql withArgumentsInArray:values];
        
        [_database close];
    }
    
    return rst;
}


- (NSArray *)queryPersonBySql:(NSString *)sql
{
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    if ([_database open])
    {
        FMResultSet *retSet = [_database executeQuery:sql];
        
        while ([retSet next])
        {
            NSMutableDictionary *dict = [[retSet resultDictionary] mutableCopy];
            
            for (NSString *key in dict.allKeys)
            {
                id value = [dict objectForKey:key];
                
                if ([value isKindOfClass:[NSData class]])
                {
                    id jsonObj = [value toJsonObject];
                    
                    [dict setObject:NilObject(jsonObj) forKey:key];
                }
            }
            
            FSPerson *person = [FSPerson dataWithDict:dict];
            
            if (person)
            {
                [tmpArray addObject:person];
            }
        }
    }
    
    return tmpArray;
}

@end


