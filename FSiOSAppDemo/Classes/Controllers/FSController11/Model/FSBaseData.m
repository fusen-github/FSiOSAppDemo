//
//  FSBaseData.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/12.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSBaseData.h"
#import <objc/runtime.h>


@implementation FSBaseData

//- (NSDictionary *)autoExportPropertyValues:(Class)clazz
//{
//    NSMutableDictionary *props = [NSMutableDictionary dictionary];
//
//    unsigned int outCount, i;
//
//    objc_property_t *properties = class_copyPropertyList(clazz, &outCount);
//
//    for (i = 0; i < outCount; i++)
//    {
//        objc_property_t property = properties[i];
//
//        const char* char_f = property_getName(property);
//
//        NSString *propertyName = [NSString stringWithUTF8String:char_f];
//
//        id propertyValue = [self valueForKey:(NSString *)propertyName];
//
//        const char * attributes = property_getAttributes(property);//获取属性类型
//
//        //        if (strcmp(attributes, "T@,C,N,V_content") == 0)
//        //        {
//        //            NSLog(@"到了");
//        //        }
//
//        NSString *propertyType = [NSString stringWithUTF8String:attributes];
//
//        if ([propertyType hasPrefix:@"T@"])
//        {
//            NSUInteger loc = [propertyType rangeOfString:@","].location;
//
//            if(loc >= 4){
//
//                propertyType = [propertyType substringWithRange:NSMakeRange(3, loc - 4)];
//            }
//            else propertyType = nil;
//        }
//
//        if(!propertyType){
//
//            if([propertyValue isKindOfClass:[NSString class]]){
//
//                propertyType = @"NSString";
//            }
//            else if([propertyValue isKindOfClass:[NSArray class]]){
//
//                propertyType = @"NSArray";
//
//            }
//            else if([propertyValue isKindOfClass:[NSDictionary class]]){
//
//                propertyType = @"NSDictionary";
//            }
//        }
//
//        if([propertyValue isKindOfClass:[FDBaseData class]])
//        {
//            FDBaseData *baseData = propertyValue;
//
//            [props setObject:NilObject([baseData toDictionary]) forKey:propertyName];
//        }
//        else if([propertyType isEqualToString:@"NSArray"]
//                || [propertyType isEqualToString:@"NSMutableArray"])
//        {
//            NSMutableArray *array = [NSMutableArray array];
//
//            if(propertyValue && ![propertyValue isKindOfClass:[NSArray class]])
//            {
//                NSLog(@"%@不是数组类型的Value",propertyName);
//
//                continue;
//            }
//
//            for (id value in propertyValue) {
//
//                if ([value isKindOfClass:[FDBaseData class]])
//                {
//                    FDBaseData *baseData = value;
//
//                    [array addObject:[baseData toDictionary]];
//                }
//                else
//                {
//                    [array addObject:value];
//                }
//            }
//
//            [props setObject:array forKey:propertyName];
//        }
//        else if([propertyType isEqualToString:@"NSDictionary"] ||
//                [propertyType isEqualToString:@"NSMutableDictionary"])
//        {
//            if(!propertyValue || [propertyValue isKindOfClass:[NSNull class]])
//            {
//                [props setObject:[NSNull null] forKey:propertyName];
//            }
//            else [props setObject:propertyValue forKey:propertyName];
//        }
//        else if([propertyType isEqualToString:@"NSString"])// && _emptyString)
//        {
//            if(!propertyValue || [propertyValue isKindOfClass:[NSNull class]])
//            {
//                [props setObject:@"" forKey:propertyName];
//            }
//            else [props setObject:propertyValue forKey:propertyName];
//        }
//        else if([propertyType isEqualToString:@"NSNumber"])// && _emptyString)
//        {
//            if(!propertyValue || [propertyValue isKindOfClass:[NSNull class]])
//            {
//                [props setObject:@(0) forKey:propertyName];
//            }
//            else [props setObject:propertyValue forKey:propertyName];
//        }
//        else {
//
//            [props setObject:NilObject(propertyValue) forKey:propertyName];
//        }
//    }
//
//    Class superClass = class_getSuperclass(clazz);
//
//    if([superClass isSubclassOfClass:[FDBaseData class]])
//    {
//        NSDictionary *ret = [self autoExportPropertyValues:superClass];
//
//        [props addEntriesFromDictionary:ret];
//    }
//
//    free(properties);
//
//    if(props.count == 0) return nil;
//
//    return props;
//}

+ (instancetype)dataWithDict:(NSDictionary *)dict
{
    return nil;
}

- (NSDictionary *)toDictionary
{
    NSDictionary *dict = [self autoExportPropertyValues:[self class]];
    
    return dict;
}

- (NSDictionary *)autoExportPropertyValues:(Class)clazz
{
    unsigned int outCount = 0;
    
    objc_property_t *properties = class_copyPropertyList([clazz class], &outCount);
    
    /// key:属性名称的NSString形式，value:属性值(NSNumber,NSString,NSDictionary,NSArray)
    NSMutableDictionary *propertyValueDict = [NSMutableDictionary dictionary];
    
    for (int i = 0; i < outCount; i++)
    {
        //        NSMutableDictionary *
        
        /// 一个属性结构体
        objc_property_t oneProperty = properties[i];
        
        /// 通过属性结构体获取属性名
        const char *c_p_name = property_getName(oneProperty);
        
        /// 属性名
        NSString *p_name = [NSString stringWithUTF8String:c_p_name];
        
//        NSLog(@"属性名：%@",p_name);
        
        /// 获取属性类型（eg:NSString, NSArray）
        const char *c_p_class_name = property_getAttributes(oneProperty);
        
        NSString *p_class_name = [NSString stringWithUTF8String:c_p_class_name];
        
//        NSLog(@"属性类型名：%@",p_class_name);
        
        if ([p_class_name hasPrefix:@"T@\""])
        {
            NSArray *tmpArr = [p_class_name componentsSeparatedByString:@"\""];
            
            if (tmpArr.count >= 2)
            {
                p_class_name = [tmpArr objectAtIndex:1];
            }
            else
            {
                p_class_name = nil;
            }
        }
        
        id p_value = [self valueForKey:p_name];
        
        if (!p_class_name.length)
        {
            if ([p_value isKindOfClass:[NSString class]])
            {
                p_class_name = @"NSString";
            }
            else if ([p_value isKindOfClass:[NSArray class]])
            {
                p_class_name = @"NSArray";
            }
            else if ([p_value isKindOfClass:[NSDictionary class]])
            {
                p_class_name = @"NSDictionary";
            }
        }
        
        /// 通过属性类型名反射属性类型
        Class fs_class = NSClassFromString(p_class_name);
        
        if ([fs_class isSubclassOfClass:[FSBaseData class]]) /// 对象
        {
            if ([p_value isKindOfClass:[FSBaseData class]])
            {
                [propertyValueDict setObject:[p_value toDictionary] forKey:p_name];
            }
            else
            {
                [propertyValueDict setObject:[NSNull null] forKey:p_name];
            }
        }
        else if ([fs_class isSubclassOfClass:[NSArray class]]) /// 属性是数组
        {
            if (![p_value isKindOfClass:[NSArray class]]) /// 属性值不是数组
            {
                [propertyValueDict setObject:@[] forKey:p_name];
                
                continue;
            }
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            for (id sub_value in p_value)
            {
                if ([sub_value isKindOfClass:[FSBaseData class]])
                {
                    [tmpArray addObject:[sub_value toDictionary]];
                }
                else
                {
                    [tmpArray addObject:sub_value];
                }
            }
            
            [propertyValueDict setObject:tmpArray forKey:p_name];
        }
        else if ([fs_class isSubclassOfClass:[NSDictionary class]]) // 字典
        {
            if (![p_value isKindOfClass:[NSDictionary class]])
            {
                [propertyValueDict setObject:[NSNull null] forKey:p_name];
            }
            else
            {
                [propertyValueDict setObject:p_value forKey:p_name];
            }
        }
        else if ([fs_class isSubclassOfClass:[NSString class]])
        {
            if (![p_value isKindOfClass:[NSString class]])
            {
                [propertyValueDict setObject:@"" forKey:p_name];
            }
            else
            {
                [propertyValueDict setObject:p_value forKey:p_name];
            }
        }
        else if ([fs_class isSubclassOfClass:[NSNumber class]])
        {
            if (![p_value isKindOfClass:[NSNumber class]])
            {
                [propertyValueDict setObject:@(0) forKey:p_name];
            }
            else
            {
                [propertyValueDict setObject:p_value forKey:p_name];
            }
        }
        else
        {
            id value = p_value ?: [NSNull null];
            
            [propertyValueDict setObject:value forKey:p_name];
        }
    }
    
    Class superclass = class_getSuperclass(clazz);

    if ([superclass isSubclassOfClass:[FSBaseData class]])
    {
        NSDictionary *superDict = [self autoExportPropertyValues:superclass];
        
        [propertyValueDict addEntriesFromDictionary:superDict];
    }
    
    free(properties);
    
    return propertyValueDict;
}



@end
