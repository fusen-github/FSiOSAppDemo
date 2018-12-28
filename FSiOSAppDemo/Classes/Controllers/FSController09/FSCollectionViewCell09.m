//
//  FSCollectionViewCell09.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/23.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCollectionViewCell09.h"

@interface FSCollectionViewCell09 ()

@property (nonatomic, weak) UIImageView *imagView;

@end

@implementation FSCollectionViewCell09

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *imagView = [[UIImageView alloc] init];
        
        self.imagView = imagView;
        
        [self.contentView addSubview:imagView];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    self.imagView.image = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imagView.frame = self.contentView.bounds;
}

@end
