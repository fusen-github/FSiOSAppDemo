//
//  FSMasterController.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/16.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSBaseViewController.h"

@class FSMasterController;
@protocol FSMasterControllerDelegate <NSObject>

@optional
- (void)master:(FSMasterController *)master wantToShowViewController:(UIViewController *)controller;

@end

@interface FSMasterController : FSBaseViewController

@property (nonatomic, weak) id<FSMasterControllerDelegate> delegate;

@end
