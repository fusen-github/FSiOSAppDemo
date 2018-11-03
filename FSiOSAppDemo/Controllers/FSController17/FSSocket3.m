//
//  FSSocket3.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/3.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSSocket3.h"
#import "FSChatView.h"
#import <netinet/in.h>
#import <sys/socket.h>
#import <arpa/inet.h>


@interface FSSocket3 ()<FSChatViewDelegate>

@property (nonatomic, assign) int clientSocket;

/**
 default NO,
 */
@property (nonatomic, assign) BOOL socketConnected;

@property (nonatomic, weak) FSChatView *chatView;

@property (atomic, strong) NSTimer *timer;

@end

@implementation FSSocket3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FSChatView *chatView = [[FSChatView alloc] init];
    
    self.chatView = chatView;
    
    chatView.delegate = self;
    
    CGFloat y = self.navigationController.navigationBar.height + 20;
    
    chatView.frame = CGRectMake(0, y, self.view.width, self.view.height - y);
    
    [self.view addSubview:chatView];
}



- (BOOL)chatView:(FSChatView *)chatView wantToConnectIp:(NSString *)ip port:(NSString *)port
{
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    self.clientSocket = clientSocket;
    
    struct sockaddr_in toAddress;
    
    toAddress.sin_family = AF_INET;
    
    toAddress.sin_port = htons(port.integerValue);
    
    toAddress.sin_addr.s_addr = inet_addr(ip.UTF8String);
    
    int connectRst = connect(clientSocket, (void *)&toAddress, sizeof(toAddress));
    
    self.socketConnected = connectRst == 0;
    
    if (connectRst != 0)
    {
        NSLog(@"连接失败...");
        
        return NO;
    }
    else
    {
        NSLog(@"连接成功...");
        
        [self openObserve];
        
        return YES;
    }
}

- (void)openObserve
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        // receivedResponse
        @autoreleasepool {
            
            [self.timer invalidate];
            
            self.timer = nil;
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(receivedResponse) userInfo:nil repeats:YES];
            
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
            
            [[NSRunLoop currentRunLoop] run];
        }
    });
}

- (void)receivedResponse
{
    NSLog(@"%@",[NSThread currentThread]);
    
    if (!self.socketConnected)
    {
        NSLog(@"连接已经断开了");
        
        return;
    }
    
    uint8_t buffer[1024 * 10];
    
    size_t recvLen = recv(self.clientSocket, buffer, sizeof(buffer), 0);
    
    if (!self.socketConnected)
    {
        NSLog(@"连接已经断开了");
        
        return;
    }
    
    if (recvLen > 0 && sizeof(buffer) > 0)
    {
        NSData *data = [NSData dataWithBytes:buffer length:recvLen];
        
        NSString *receiveMsg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.chatView receiveMsg:receiveMsg];
        });
    }
    
    NSLog(@"end");
    
}

- (void)chatView:(FSChatView *)chatView sendMessage:(NSString *)msg complec:(void (^)(BOOL))complec
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        if (!self.socketConnected)
        {
            NSLog(@"连接已经断开，不能发送消息了");
            
            return;
        }
        
        /// 返回值 是发送的字节数
        ssize_t sendSize = send(self.clientSocket, msg.UTF8String, strlen(msg.UTF8String), 0);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (complec)
            {
                complec(sendSize != 0);
            }
        });
    });
}


- (BOOL)wantToStopConnectWithChatView:(FSChatView *)chatView
{
    int rst = close(self.clientSocket);
    
    self.socketConnected = NO;
    
    [self.timer invalidate];
    
    self.timer = nil;
    
    return rst == 0;
}

- (void)dealloc
{
    NSLog(@"死了");
}

@end
