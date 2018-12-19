//
//  FSCell23.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/18.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSCell23.h"
#import "UIImageView+WebCache.h"
#import "FSNewsItem.h"


@interface FSCell23 ()

@property (nonatomic, weak) UIImageView *iconView;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UILabel *newsLabel;

@end

@implementation FSCell23

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
        /// 1
        UIImageView *iconView = [[UIImageView alloc] init];
        
        iconView.translatesAutoresizingMaskIntoConstraints = NO;
        
        iconView.backgroundColor = UIColorRandom;
        
        self.iconView = iconView;
        
        [self.contentView addSubview:iconView];
        
        
        /// 2
        UILabel *titleLabel = [[UILabel alloc] init];
        
//        titleLabel.backgroundColor = UIColorRandom;
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        titleLabel.font = [UIFont systemFontOfSize:16];
        
        titleLabel.numberOfLines = 0;
        
        self.titleLabel = titleLabel;
        
        [self.contentView addSubview:titleLabel];
        
        
        
        /// 3
        UILabel *newsLabel = [[UILabel alloc] init];
        
        newsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.newsLabel = newsLabel;
        
        newsLabel.numberOfLines = 0;
        
        newsLabel.font = [UIFont systemFontOfSize:13];
        
//        newsLabel.backgroundColor = UIColorRandom;
        
        [self.contentView addSubview:newsLabel];
        
        
        
        /// iconview的约束
        [iconView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:15].active = YES;
        
        [iconView.widthAnchor constraintEqualToConstant:40].active = YES;
        
        [iconView.heightAnchor constraintEqualToConstant:40].active = YES;
        
        [iconView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
        
        
        /// titleLable的约束
        [titleLabel.leftAnchor constraintEqualToAnchor:iconView.rightAnchor constant:10].active = YES;
        
        [titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5].active = YES;
        
        [titleLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-5].active = YES;
        
        
        /// newsLabel的约束
        [newsLabel.leftAnchor constraintEqualToAnchor:iconView.rightAnchor constant:10].active = YES;
        
        [newsLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:10].active = YES;
        
        [newsLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-5].active = YES;
        
        
        /// 约束cell.contentView的高度自适应
        [newsLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:0].active = YES;
    }
    return self;
}

- (void)setItem:(FSNewsItem *)item
{
    _item = item;
    
    NSURL *url = [NSURL URLWithString:item.imageUrl];
    
    [self.iconView sd_setImageWithURL:url];
    
    self.titleLabel.text = item.title;
    
    self.newsLabel.text = item.newsContent;
    
}

@end
