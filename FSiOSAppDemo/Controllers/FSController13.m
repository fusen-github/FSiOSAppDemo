//
//  FSController13.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/18.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController13.h"
#import <MessageUI/MessageUI.h>
#import <SMTPLibrary/SKPSMTPMessage.h>
//#import <SMTPLibrary/NSData+Base64Additions.h>

//#import "SKPSMTPMessage.h"
//#import "NSData+Base64Additions.h"

@interface FSController13 ()<SKPSMTPMessageDelegate>

@end

@implementation FSController13

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"email" style:UIBarButtonItemStylePlain target:self action:@selector(doRightAction)];
    
}

- (void)doRightAction
{
    SKPSMTPMessage *testSend = [[SKPSMTPMessage alloc]init];
    
    testSend.fromEmail = @"发送方@mail.com";
    
    testSend.toEmail = @"接收方@mail.com";
    
    /*
     发送方邮箱的服务器地址 eg：163邮箱的服务器地址smtp.163.com
     */
    testSend.relayHost = @"smtp.163.com";
    
    testSend.requiresAuth = YES;
    
    if (testSend.requiresAuth)
    {
        testSend.login = @"发送方@mail.com";
        
        /*
         1、发送方邮箱密码
         2、发送方授权码登录第三方邮件客户端的授权码。(比如网易邮箱需要到邮箱设置中设置第三方登陆授权码)
         */
        testSend.pass = @"";
    }
    
    
    /*
     邮件主题名
     */
    testSend.subject = @"邮件主题名";
    
    testSend.wantsSecure = YES;
    
    testSend.delegate = self;
    
    
    /// 邮件的内容，可以是附件等
    NSDictionary *plainPart = @{kSKPSMTPPartContentTypeKey:@"text/plain; charset=UTF-8",
                                kSKPSMTPPartMessageKey:@"This is a test message.",
                                kSKPSMTPPartContentTransferEncodingKey:@"8bit"};
    
    testSend.parts = [NSArray arrayWithObjects:plainPart, nil];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        [testSend send];
    });
}


-(void)messageSent:(SKPSMTPMessage *)message
{
    NSLog(@"%s",__func__);
}


-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    NSLog(@"错误码：%ld",error.code);
    
    NSLog(@"错误描述：%@",error.localizedDescription);
}

@end
