//
//  FSController10.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, FSTestEnumType){
 
    FSTestEnumType1,
    FSTestEnumType2,
    FSTestEnumType3,
    FSTestEnumType4,
};

@class Person;

enum enmPasType : NSInteger;

typedef enum enmPasType enmPasType;

@interface FSController10 : UIViewController

@property (nonatomic, assign) enmPasType pas;

@end
