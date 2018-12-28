//
//  FSCollectionViewLayout.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/23.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSCollectionViewLayout : UICollectionViewLayout

// default is UICollectionViewScrollDirectionVertical
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic) CGSize itemSize;

@property (nonatomic) NSUInteger visibleCount;

@end
