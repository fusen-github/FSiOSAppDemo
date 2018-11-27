//
//  FSSocket2.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/3.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSSocket2.h"
#import <sys/socket.h>
#import <netinet/in.h>
// 'Net'work  ->(net)网络
// 'I'nter'net' ->(inet/in)因特网
#import <arpa/inet.h>



@interface FSSocket2 ()

@end

@implementation FSSocket2

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self socketDemo];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self socketDemo];
}

/*
 socket定义:
 网络上两个程序通过一个双向通讯连接实现数据交换，连接的一端称为一个socket
 双向通讯的连接可以理解成是一条双向行驶的道路。
 http协议就相当于一辆货车。负责在这个已经连接的道路上双向的运输(传输)数据
 */

- (void)socketDemo
{
    
    // 1、创建客户端socket
    /**
     创建socket的函数
     注意：1.type和protocol不可以随意组合，如SOCK_STREAM不可以跟IPPROTO_UDP组合。
     2.当第三个参数为0时，会自动选择第二个参数类型对应的默认协议。
     
     参数1: domain 协议域。决定了socket的地址类型,通讯中必须采用对应的地址。常用的协议族有AF_INET(ipv4)、AF_INET6(ipv6)
     参数2: type   类型。指定socket类型. 常用的socket类型有SOCK_STREAM(tcp)、SOCK_DGRAM(udp)
     参数3: protocol 协议. 常用协议有IPPROTO_TCP、IPPROTO_UDP、IPPROTO_STCP、IPPROTO_TIPC等，分别对应TCP传输协议、UDP传输协议、STCP传输协议、TIPC传输协议。
     
     返回值: 如果调用成功就返回新创建的套接字的描述符，如果失败就返回INVALID_SOCKET（Linux下失败返回-1）。套接字描述符是一个整数类型的值。每个进程的进程空间里都有一个套接字描述符表，该表中存放着套接字描述符和套接字数据结构的对应关系。该表中有一个字段存放新创建的套接字的描述符，另一个字段存放套接字数据结构的地址，因此根据套接字描述符就可以找到其对应的套接字数据结构。每个进程在自己的进程空间里都有一个套接字描述符表但是套接字数据结构都是在操作系统的内核缓冲里。
     */
    int clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    
    
    // 2、建立连接
    /// 创建一个目的地地址的结构体
    struct sockaddr_in toAddress;
    
    /// 目的地地址类型 ipv4
    toAddress.sin_family = AF_INET;
    
    /// 目的地端口号 端口号要借助htons函数
    toAddress.sin_port = htons(12345);
    
    /// 下面这个直接设置端口号的代码会导致不能成功建立连接
    //    toAddress.sin_port = 12345;
    
    /// 目的地主机ip地址
    toAddress.sin_addr.s_addr = inet_addr("192.168.0.102");
    
    /* ps：当需要让电脑充当目的主机时，需要在mac的终端里用 "nc -lk 端口号"命令。开启一个消息监听 */
    
    /**
     建立一个通讯连接(相当于在通讯的双方建立一个通道)。有些语言中函数名叫bind.其功能是相同的
     
     参数1: socket, 其中一方的socket描述符
     参数2: address, 是一个sockaddr的结构体指针。该结构体中包含了要连接的地址和端口号
     参数3: address_len, 确定地址缓冲区的长度
     返回值: 如果函数执行成功，返回值为0，否则为SOCKET_ERROR
     */
    int result = connect(clientSocket, (void *)&toAddress, sizeof(toAddress));
    
    if (result == 0)
    {
        NSLog(@"成功");
    }
    else
    {
        NSLog(@"失败");
        
        return;
    }
    
    // 3、客户端发送数据
    
    NSString *message = @"你好，我是FS\n";
    
    /**
     客户端发送数据
     
     参数1: socket. 客户端scocke描述符
     参数2: buf. 待发送的内容
     参数3: size. 待发送内容的长度
     参数4: flag. 发送方式标识，一般传0
     返回值: 如果发送成功，返回发送数据的字节数。发送失败返回0
     */
    ssize_t sendResult = send(clientSocket, [message UTF8String], strlen([message UTF8String]), 0);
    
    NSLog(@"成功发送了%ld个字节",sendResult);
    
    
    
    //  4、客户端接收数据
    
    //定义接收数据的缓冲区
    uint8_t buf[1024]; // 1024表示一次最多接收到的字节数
    
    /**
     从目的地接收数据
     
     参数1: clientSocket. 客户端socket描述符
     参数2: buf. 用来接收数据的缓冲区。缓冲区大小是由开发者来设定的
     参数3: buf.len 用来接收数据缓冲区的大小(容量)，
     参数4: flag 接收数据标记。通常传0，表示一直等待对方(服务器、目的地)回应消息
     返回值: recvLen 返回接收到的数据字节大小
     */
    ssize_t recvLen = recv(clientSocket, buf, sizeof(buf), 0);
    
    NSLog(@"接收到%ld个字节",recvLen);
    
    NSData *recvData = [NSData dataWithBytes:buf length:recvLen];
    
    NSString *info = [[NSString alloc] initWithData:recvData encoding:NSUTF8StringEncoding];
    
    NSLog(@"接收到的信息: %@",info);
    
    //  5、客户端断开连接
    /*
     客户端到服务器的连接方式有长连接和短连接
     长连接:建立一次连接，该连接就保持不断。即使在2个socket之间不需要传输数据时该连接一直存在。除非关闭设备
     短连接:每次需要通讯时才建立连接。通讯结束后连接自动断开。http协议属于短连接
     */
    close(clientSocket);
    
}


@end
