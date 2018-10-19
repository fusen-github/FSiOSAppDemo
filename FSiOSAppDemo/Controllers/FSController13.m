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

static NSString * const kTitleKey = @"title";

static NSString * const kSelectorKey = @"selector";

@interface FSController13 ()

@property (nonatomic, strong) NSArray *buttonArray;

@end

@implementation FSController13

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *base = @"1faksdkaksdkcaskdcasdlkcaklsdklc;kasdkc;alsdmckasdmlkcmlkasdmlkcmksdmckasmdlkmcklasdkcsdmlkcmaksdmckasdmklcmasdkmkmalksdmckdsldmclkasmdcmaskdmckasdkcakskasdlcmalk";
    
    NSString *title1 = base;
    
    NSString *title2 = [NSString stringWithFormat:@"%@%@",base,base];
    
    NSString *title3 = [NSString stringWithFormat:@"%@%@%@",base,base,base];
    
    NSArray *array = @[@{kSelectorKey:@"doSendEmail", kTitleKey:@"发送邮件"},
                       @{kSelectorKey:@"jumpSetting", kTitleKey:@"跳转到设置"},
                       @{kSelectorKey:@"", kTitleKey:title1},
                       @{kSelectorKey:@"", kTitleKey:title2},
                       @{kSelectorKey:@"", kTitleKey:title3},];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++)
    {
        NSDictionary *dict = [array objectAtIndex:i];
        
        NSString *title = [dict objectForKey:kTitleKey];
        
        NSString *actionName = [dict objectForKey:kSelectorKey];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.layer.borderWidth = 0.5;
        
        button.layer.borderColor = [UIColor redColor].CGColor;
        
        button.layer.cornerRadius = 3;
        
        [button setTitle:title forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        
        if (actionName.length)
        {
            SEL action = NSSelectorFromString(actionName);
            
            [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.view addSubview:button];
        
        [tmpArray addObject:button];
    }
    
    self.buttonArray = tmpArray;
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGFloat top = 64;
    
    CGFloat margin = 15;
    
    CGFloat btnX = 0;

    CGFloat btnY = 0;

    CGFloat btnW = 50;

    CGFloat btnH = 35;
    
    CGFloat btnMaxW = self.view.width - 2 * margin;
    
    UIView *lastView;
    
    /*
     多按钮宽度自适应布局
     1、当父视图剩余的宽度不足以显示按钮时，则换到下一行布局
     2、当父视图的全部宽度减去左右空白部分剩下的宽度还是小于按钮的宽度时，按钮就保持最大宽度(butto.supperView.width - 2 * margin)，同时按钮的文字换行显示
     */
    
    for (int i = 0; i < self.buttonArray.count; i++)
    {
        UIButton *button = self.buttonArray[i];
        
        [button sizeToFit];
        
        btnW = button.width + 10;
        
        if (btnW > btnMaxW)
        {
            btnW = btnMaxW;
            
            button.titleLabel.numberOfLines = 0;
            
            NSString *title = [button titleForState:UIControlStateNormal];
            
            UIFont *font = button.titleLabel.font;
            
            NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
            
            NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
            
            [attributes setObject:font forKey:NSFontAttributeName];
            
            CGFloat insetValue = 5;
            
            button.titleEdgeInsets = UIEdgeInsetsMake(0, insetValue, 0, insetValue);
            
            CGRect rect = [title boundingRectWithSize:CGSizeMake(btnMaxW - 2 * insetValue, CGFLOAT_MAX) options:options attributes:attributes context:nil];
            
            btnH = rect.size.height + 8;
        }
        else
        {
            btnH = button.height + 4;
        }
        
        btnX = lastView.maxX + margin;
        
        btnY = lastView ? lastView.y : (top + margin);
        
        if (btnX + btnW > self.view.width)
        {
            btnX = margin;
            
            btnY = lastView.maxY + margin;
        }
        
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        lastView = button;
    }
}


@end

@implementation FSController13 (Email)

- (void)doSendEmail
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
    
    testSend.delegate = (id<SKPSMTPMessageDelegate>)self;
    
    
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

@implementation FSController13 (JumpSetting)

/**
 在应用2中通过openURL方法打开应用1
 一、配置应用1的URL Scheme
    1、依次选中应用1的工程文件->TARGET->Info->URL Types
    2、添加一组Identifier(字符串eg:com.companyName.appName)和URL Schemes(字符串eg:FSDemoApp01)。(可以添加多组)
    3、在应用2的info.plist中添加LSApplicationQueriesSchemes(Array)键，
    4、再在应用2的LSApplicationQueriesSchemes键下添加应用1的URL Schemes(eg:FSDemoApp01)。(可以添加多组)
    5、在应用2中调用openURL方法。其中url = [NSURL URLWithString:@"FSDemoApp01://"]
    6、此时应用1的application:openURL:options:方法会被执行
 */
- (void)jumpSetting
{
    /*
     系统设置app:App-Prefs:root=WIFI
     微信:weixin://
     蓝牙:App-Prefs:root=Bluetooth
     */
    
    NSURL *url = [NSURL URLWithString:@"avfoundation://"];
    
    UIApplication *app = [UIApplication sharedApplication];
    
    if ([app canOpenURL:url])
    {
        if (@available(iOS 10.0, *))
        {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            
            [dict setObject:@(NO) forKey:UIApplicationOpenURLOptionUniversalLinksOnly];
            
            [app openURL:url options:dict completionHandler:^(BOOL success) {
               
                NSLog(@"打开结果: %d",success);
            }];
        }
        else
        {
            [app openURL:url];
        }
    }
}

@end
