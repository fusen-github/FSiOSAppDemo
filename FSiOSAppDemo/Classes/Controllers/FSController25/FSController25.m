//
//  FSController25.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/19.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController25.h"

@interface FSController25 ()

@property (nonatomic, weak) UITextView *textView;

@end

@implementation FSController25

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *textView = [[UITextView alloc] init];
    
    self.textView = textView;
    
    textView.center = self.view.center;
    
    textView.backgroundColor = UIColorRandom;
    
    [textView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.view addSubview:textView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGRect frame = self.textView.frame;
    
    self.textView.bounds = CGRectMake(0, 0, 200, frame.size.height + 10);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"%@", change);
}

@end
