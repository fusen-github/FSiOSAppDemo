//
//  FSSocket1.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/3.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSSocket1.h"
#import <sys/socket.h>
#import <netinet/in.h>
// 'Net'work  ->(net)网络
// 'I'nter'net' ->(inet/in)因特网
#import <arpa/inet.h>


@interface FSSocket1 ()

@end

@implementation FSSocket1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self connection];
}



// MARK: Socket 演练
- (void)connection {
    // 1. socket
    /**
     参数
     
     domain:    协议域，AF_INET，IPV4
     type:      Socket 类型，SOCK_STREAM(TCP)/SOCK_DGRAM(报文，UDP协议)
     protocol:  IPPROTO_TCP，如果指定0，可以根据 type，自动判断
     
     返回值
     socket > 0，就表示成功
     */
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    // 2. connection
    /**
     参数
     1> 客户端socket
     2> 指向数据结构sockaddr的指针，其中包括目的端口和IP地址
     3> 结构体数据长度
     返回值
     0 成功/其他 错误代号
     在 C 语言的框架中，非常常见的一种技巧：意味成功只有一种，失败可以有很多种！
     */
    // 服务器地址的结构体
    struct sockaddr_in serverAddr;
    // 协议
    serverAddr.sin_family = AF_INET;
    // 端口
    serverAddr.sin_port = htons(12345);
    // ip地址的数字
    serverAddr.sin_addr.s_addr = inet_addr("192.168.0.102");
    
    // 在 C 语言开发中，经常会看到传递结构体指针的同时，传递结构体的长度！
    int result = connect(clientSocket, (const struct sockaddr *)&serverAddr, sizeof(serverAddr));
    
    if (result == 0) {
        NSLog(@"成功");
    } else {
        NSLog(@"失败");
    }
    
    // 3. 发送数据
    /**
     参数
     1> 客户端socket
     2> 发送内容地址
     3> 发送内容长度
     4> 发送方式标志，一般为0
     返回值
     如果成功，则返回发送的字节数，失败则返回SOCKET_ERROR
     */
    // UTF8String => const char *
    // strlen(message.UTF8String) 返回ascii的字符串长度，UTF中文占3个字节
    // message.length 返回中文占1个长度
    NSString *message = @"你好，我是FS\n";
    ssize_t sendLen = send(clientSocket, message.UTF8String, strlen(message.UTF8String), 0);
    NSLog(@"发送了 %ld 个字节", sendLen);
    
    // 4. 接收数据
    /**
     参数
     1. socket
     2. 接收内容的地址
     3. 接收内容的长度
     4. 接收的标记，通常是0，阻塞式的等待，一直等待服务器返回内容
     通常在网络开发中，都是你来我往的！
     
     返回值
     接收到的数据长度
     */
    // 定义了一个无符号char的数组
    uint8_t buffer[1024];
    
    ssize_t recvLen = recv(clientSocket, buffer, sizeof(buffer), 0);
    NSLog(@"接收到 %ld 个字节", recvLen);
    // 获取接收到的数据
    NSData *data = [NSData dataWithBytes:buffer length:recvLen];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", str);
    
    // 5. 断开连接
    /**
     长连接：长期的连接，始终保持连接！
     短连接：短期的连接，断开连接，通讯就结束
     */
    close(clientSocket);
}

@end
