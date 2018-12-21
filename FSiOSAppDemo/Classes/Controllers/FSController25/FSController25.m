//
//  FSController25.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/12/19.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController25.h"
#import "FSViscosityView.h"

static CGFloat const kTextViewMaxHeight = 84;

@interface FSController25 ()<UITextViewDelegate>

@property (nonatomic, weak) UITextView *textView;

@end

@implementation FSController25

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demo01];
    
}


- (void)demo01
{
    UITextView *textView = [[UITextView alloc] init];
    
    self.textView = textView;
    
    UIEdgeInsets edgeInsets = textView.textContainerInset;
    
    edgeInsets.top = 6.5;
    
    edgeInsets.bottom = 6.5;
    
    textView.textContainerInset = edgeInsets;
    
    textView.delegate = self;
    
    textView.layer.borderColor = [UIColor redColor].CGColor;
    
    textView.layer.borderWidth = 0.5;
    
    textView.layer.cornerRadius = 3;
    
    textView.font = [UIFont systemFontOfSize:16];
    
    textView.layer.masksToBounds = YES;
    
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    
    textView.scrollEnabled = NO;
    
    [self.view addSubview:textView];
    
    [textView addObserver:self
               forKeyPath:@"bounds"
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:nil];
    
    [textView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20].active = YES;
    
    [textView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    
    [textView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20].active = YES;
    
    [textView.heightAnchor constraintGreaterThanOrEqualToConstant:35].active = YES;
    
    CGFloat h = kTextViewMaxHeight;
    
    [textView.heightAnchor constraintLessThanOrEqualToConstant:h].active = YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.scrollEnabled)
    {
        CGPoint point = CGPointMake(0, textView.contentSize.height - textView.bounds.size.height);
        
        if (textView.contentOffset.y != point.y)
        {
            [textView setContentOffset:point animated:YES];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"bounds"])
    {
        CGSize newSize = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue].size;
        
        CGSize oldSize = [[change objectForKey:NSKeyValueChangeOldKey] CGRectValue].size;
        
        if (oldSize.height < newSize.height)
        {
            if (newSize.height == kTextViewMaxHeight && !self.textView.scrollEnabled)
            {
                self.textView.scrollEnabled = YES;
                
                CGPoint point = CGPointMake(0, self.textView.contentSize.height - self.textView.bounds.size.height);

                [self.textView setContentOffset:point animated:YES];
            }
        }
        else if (oldSize.height > newSize.height)
        {
            if (self.textView.scrollEnabled)
            {
                self.textView.scrollEnabled = NO;
                
                [self.textView setNeedsUpdateConstraints];
            }
        }
        else
        {
            NSLog(@"oldSize = newSize");
            
            CGSize contentSize = self.textView.contentSize;
            
            if (contentSize.height < newSize.height)
            {
                if (self.textView.scrollEnabled)
                {
                    self.textView.scrollEnabled = NO;
                    
                    [self.textView setNeedsUpdateConstraints];
                }
                else
                {
                    NSLog(@"11111");
                }
            }
            else
            {
                NSLog(@"22222");
            }
        }
    }
}

@end
