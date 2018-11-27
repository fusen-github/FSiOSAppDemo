//
//  FSImageCollectionViewCell.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/26.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSImageCollectionViewCell.h"

@interface FSImageCollectionViewCell ()

@end

@implementation FSImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    UIImageView *imageView = [[UIImageView alloc] init];
    
    _imageView = imageView;
    
    imageView.backgroundColor = [UIColor blueColor];
    
    [self.contentView addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}

@end


