//
//  FSImageContainer.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/25.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSImageScrollView.h"


@interface FSImageContainer : UIViewController

- (instancetype)initWithPlaceholdImage:(UIImage *)phImage;

@property (nonatomic, weak, readonly) FSImageScrollView *scrollView;

@end
