//
//  FSChatView.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/3.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FSSocketState) {
    FSSocketStateNone,
    FSSocketStateConnected,
    FSSocketStateUnconnected,
};

@class FSChatView;
@protocol FSChatViewDelegate <NSObject>

@optional
- (BOOL)chatView:(FSChatView *)chatView wantToConnectIp:(NSString *)ip port:(NSString *)port;

- (void)chatView:(FSChatView *)chatView sendMessage:(NSString *)msg complec:(void(^)(BOOL suc))complec;

- (BOOL)wantToStopConnectWithChatView:(FSChatView *)chatView;

@end

@interface FSChatView : UIView

@property (nonatomic, weak) id<FSChatViewDelegate> delegate;

- (void)receiveMsg:(NSString *)msg;

@end
