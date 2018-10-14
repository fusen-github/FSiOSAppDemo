//
//  FS10CollectionViewCell.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/9/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FS10CollectionViewCell.h"

@interface FS10CollectionViewCell ()

@property (nonatomic, weak) UILabel *descLabel;

@end

@implementation FS10CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *descLabel = [[UILabel alloc] init];
        
        self.descLabel = descLabel;
        
        descLabel.font = [UIFont systemFontOfSize:14];
        
        descLabel.textColor = [UIColor darkTextColor];
        
        descLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:descLabel];
    }
    return self;
}

- (void)setDesc:(NSString *)desc
{
    _desc = [desc copy];
    
    self.descLabel.text = _desc;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.descLabel.frame = self.contentView.bounds;
}

@end
