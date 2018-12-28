//
//  FSQQRefreshHeader.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/27.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSQQRefreshHeader.h"



@interface FSQQRefreshHeader ()

@property (nonatomic, assign) FSRefreshStatus status;

@property (nonatomic, weak) UILabel *textLabel;

@property (nonatomic, weak) UIActivityIndicatorView *activityView;

@property (nonatomic, assign) BOOL showSuc;

@end

@implementation FSQQRefreshHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.backgroundColor = [UIColor clearColor];
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        self.activityView = activityView;
        
        [self addSubview:activityView];
        
        UILabel *textLabel = [[UILabel alloc] init];
        
        textLabel.textColor = [UIColor lightGrayColor];
        
        self.textLabel = textLabel;
        
        textLabel.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:textLabel];
        
        self.status = FSRefreshStatusIdle;
    }
    return self;
}





@end
