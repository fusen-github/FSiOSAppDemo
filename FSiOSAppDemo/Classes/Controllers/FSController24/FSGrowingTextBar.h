//
//  FSGrowingTextBar.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/19.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSGrowingTextBar;
@protocol FSGrowingTextBarDelegate <NSObject>

@optional
- (void)bar:(FSGrowingTextBar *)bar keyboardWillAppearWithUserInfo:(NSDictionary *)userInfo;

- (void)bar:(FSGrowingTextBar *)bar keyboardWillDisappearWithUserInfo:(NSDictionary *)userInfo;

- (void)bar:(FSGrowingTextBar *)bar textDidChanged:(NSString *)text;

@end

@interface FSGrowingTextBar : UIView

@property (nonatomic, weak) id<FSGrowingTextBarDelegate> delegate;

@end
