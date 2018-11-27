//
//  FSChatView.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/3.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSChatView.h"

@interface FSChatView ()

@property (nonatomic, weak) UILabel *saLabel;

@property (nonatomic, weak) UITextField *saTF;

@property (nonatomic, weak) UILabel *portLabel;

@property (nonatomic, weak) UITextField *portTF;

@property (nonatomic, weak)  UIButton *connectBtn;

@property (nonatomic, weak) UITextView *chatTextView;

@property (nonatomic, weak) UITextField *sendTF;

@property (nonatomic, weak) UIButton *sendBtn;

@end

@implementation FSChatView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    /// 服务ip标签
    UILabel *saLabel = [self labelWithText:@"服务器IP地址:"];
    
    self.saLabel = saLabel;
    
    [self addSubview:saLabel];
    
    /// ip textField
    UITextField *saTF = [self textFieldWithPlaceholder:@"请输入目的IP地址..."];
    
    saTF.text = @"192.168.0.102";
    
    self.saTF = saTF;
    
    [self addSubview:saTF];
    
    /// 端口号
    UILabel *portLabel = [self labelWithText:@"服务器端口号:"];
    
    self.portLabel = portLabel;
    
    [self addSubview:portLabel];
    
    /// ip textField
    UITextField *portTF = [self textFieldWithPlaceholder:@"请输入目的主机端口号..."];
    
    portTF.text = @"12345";
    
    self.portTF = portTF;
    
    [self addSubview:portTF];
    
    /// 连接按钮
    UIButton *connectBtn = [self buttonWithTitle:@"连接"];
    
    self.connectBtn = connectBtn;
    
    [connectBtn setTitle:@"断开连接" forState:UIControlStateSelected];
    
    [connectBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    [connectBtn addTarget:self action:@selector(connectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:connectBtn];
    
    
    UITextView *chatTextView = [[UITextView alloc] init];
    
    chatTextView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.chatTextView = chatTextView;
    
    chatTextView.textColor = [UIColor darkTextColor];
    
    chatTextView.font = [UIFont systemFontOfSize:14];
    
    [self addSubview:chatTextView];
    
    UITextField *sendTF = [self textFieldWithPlaceholder:@"请输入要发送的信息"];
    
    self.sendTF = sendTF;
    
    [self addSubview:sendTF];
    
    
    UIButton *sendBtn = [self buttonWithTitle:@"发送"];
    
    self.sendBtn = sendBtn;
    
    [sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:sendBtn];
}

- (void)receiveMsg:(NSString *)msg
{
    if (!msg.length) return;
    
    NSString *message = [@"对方: " stringByAppendingString:msg];
    
    NSString *text = self.chatTextView.text;
    
    text = [text stringByAppendingString:message];

    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    
    NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
    
    pStyle.lineSpacing = 10;
    
    [attributes setObject:pStyle forKey:NSParagraphStyleAttributeName];
    
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
    self.chatTextView.attributedText = attributedText;
    
    [self.chatTextView scrollRangeToVisible:NSMakeRange(text.length, 1)];
}

- (void)connectAction:(UIButton *)button
{
    if (!button.selected)
    {
        BOOL suc = NO;
        
        if ([self.delegate respondsToSelector:@selector(chatView:wantToConnectIp:port:)])
        {
            suc = [self.delegate chatView:self wantToConnectIp:self.saTF.text port:self.portTF.text];
            
            button.selected = suc;
        }
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(wantToStopConnectWithChatView:)])
        {
            BOOL suc = [self.delegate wantToStopConnectWithChatView:self];
            
            button.selected = !suc;
        }
    }
}

- (void)sendAction:(UIButton *)button
{
    if (!self.sendTF.text.length)
    {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(chatView:sendMessage:complec:)])
    {
        NSString *message = [self.sendTF.text stringByAppendingString:@"\n"];
        
        __weak typeof(self) wSelf = self;
        
        [self.delegate chatView:self sendMessage:message complec:^(BOOL suc) {
            
            if (suc)
            {
                [wSelf sendMessageSuc:message];
            }
            
        }];
    }
}

- (void)sendMessageSuc:(NSString *)msg
{
    self.sendTF.text = nil;
    
    NSString *message = [@"我: " stringByAppendingString:msg];
    
    NSString *text = self.chatTextView.text;
    
    text = [text stringByAppendingString:message];
    
    self.chatTextView.text = text;
    
    [self.chatTextView scrollRangeToVisible:NSMakeRange(text.length, 1)];
}


- (UIButton *)buttonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    button.layer.cornerRadius = 5;
    
    button.layer.masksToBounds = YES;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.backgroundColor = kMainBlueColor;
    
    return button;
}

- (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] init];
    
    textField.placeholder = placeholder;
    
    textField.font = [UIFont systemFontOfSize:14];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    
    textField.leftView = leftView;
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.layer.cornerRadius = 5;
    
    textField.layer.masksToBounds = YES;
    
    textField.layer.borderColor = [UIColor redColor].CGColor;
    
    textField.layer.borderWidth = 1;
    
    return textField;
}



- (UILabel *)labelWithText:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    
    label.textColor = [UIColor darkTextColor];
    
    label.font = [UIFont systemFontOfSize:14];
    
    label.text = text;
    
    return label;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat left = 15;
    
    CGFloat top = 20;
    
    CGFloat tfH = 30;
    
    [self.saLabel sizeToFit];
    
    self.saLabel.frame = CGRectMake(left, top, self.saLabel.width, tfH);
    
    self.saTF.frame = CGRectMake(self.saLabel.maxX + 5, top, 200, tfH);
    
    [self.portLabel sizeToFit];
    
    self.portLabel.frame = CGRectMake(left, self.saLabel.maxY + 10, self.portLabel.width, tfH);
    
    self.portTF.frame = CGRectMake(self.portLabel.maxX + 5, self.portLabel.y, 200, tfH);
    
    self.connectBtn.frame = CGRectMake(left, self.portLabel.maxY + 20, 80, 30);
    
    CGFloat chatY = self.connectBtn.maxY + 20;
    
    CGFloat chatH = self.height - chatY - tfH - 40;
    
    chatH = MIN(chatH, 200);
    
    self.chatTextView.frame = CGRectMake(left, chatY, self.width - 2 * left, chatH);
    
    self.sendTF.frame = CGRectMake(left, self.chatTextView.maxY + 20, 250, tfH);
    
    self.sendBtn.frame = CGRectMake(self.sendTF.maxX + 20, self.sendTF.y, 80, tfH);
}

@end
