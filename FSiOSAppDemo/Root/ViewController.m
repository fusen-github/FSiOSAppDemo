//
//  ViewController.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/8/20.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "ViewController.h"
#import "FSBaseView.h"

static NSString * const kControllerNameKey = @"kControllerNameKey";

static NSString * const kControllerTitleKey = @"kControllerTitleKey";

@interface ViewController ()<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导航控制器";
    
    self.dataArray =
  @[@{kControllerNameKey:@"FSController01",kControllerTitleKey:@"NSOperation"},
    @{kControllerNameKey:@"FSController02",kControllerTitleKey:@"UIButton"},
    @{kControllerNameKey:@"FSController03",kControllerTitleKey:@"UIAlertController"},
    @{kControllerNameKey:@"FSController04",kControllerTitleKey:@"UIPopoverPresentationController"},
    @{kControllerNameKey:@"FSController05",kControllerTitleKey:@"UIInterfaceOrientationMask"},
    @{kControllerNameKey:@"FSController06",kControllerTitleKey:@"UIVisualEffectView"},
    @{kControllerNameKey:@"FSController07",kControllerTitleKey:@"UISplitViewController"},
    @{kControllerNameKey:@"FSController08",kControllerTitleKey:@"UITableView"},
    @{kControllerNameKey:@"FSController09",kControllerTitleKey:@"UICollectionView"},
    @{kControllerNameKey:@"FSController10",kControllerTitleKey:@"UserNotifications"},
    @{kControllerNameKey:@"FSController11",kControllerTitleKey:@"SQLite3"},
    @{kControllerNameKey:@"FSController12",kControllerTitleKey:@"GCD"},
    @{kControllerNameKey:@"FSController13",kControllerTitleKey:@"多功能"},
    @{kControllerNameKey:@"FSController14",kControllerTitleKey:@"NSOperation & NSOperationQueue"},
    @{kControllerNameKey:@"FSController15",kControllerTitleKey:@"NSThread"},
    @{kControllerNameKey:@"FSController16",kControllerTitleKey:@"CoreGraphics"},
    @{kControllerNameKey:@"FSController17",kControllerTitleKey:@"Socket"},
];
    
    
    
    // UserNotifications
    UITableView *tableView = [[UITableView alloc] init];
    
    tableView.frame = self.view.bounds;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    
    NSString *title = [dict objectForKey:kControllerTitleKey];
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    
    NSString *className = [dict objectForKey:kControllerNameKey];
    
    Class class = NSClassFromString(className);
    
    if (![class isSubclassOfClass:[UIViewController class]])
    {
        return;
    }
    
    NSString *title = [dict objectForKey:kControllerTitleKey];
    
    id obj = [[class alloc] init];
    
    if ([className isEqualToString:@"FSController07"])
    {
        [self presentViewController:obj animated:YES completion:nil];
    }
    else
    {
        [obj setTitle:title];
        
        [self.navigationController pushViewController:obj animated:YES];
    }

    
}



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
//    NSLog(@"LAILE");
    
    return NO;
}

- (void)demo04
{
    NSString *name = NSLocalizedStringFromTable(@"name", @"File", nil);
    
    NSString *age = NSLocalizedStringFromTable(@"age", @"File", nil);
    
    NSLog(@"%@",name);
    
    id dict = [[NSBundle mainBundle] infoDictionary];
    
    //    NSLog(@"%@",dict);
    
    NSAssert(NO, @"12345", @"6789", @"abcd");
    
    NSLog(@"laile");
}

- (void)demo03
{
    UIControl *control = [[UIControl alloc] init];
    
    control.backgroundColor = [UIColor greenColor];
    
    control.frame = CGRectMake(0, 70, self.view.bounds.size.width, 100);
    
    [control addTarget:self
                action:@selector(doSomething)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:control];
    
    UITextView *textView = [[UITextView alloc] init];
    
    textView.text = @"fasdfasdfasdfasldcnaksdcjnasdkjnclkjasndlkcjnaksjdnclkjasndlckajsdnckjasndkjckajsdnckjansdjkjcnsdjncjkasndkjckjasndckjnasjkdnckjasndkjasndkljcnakljsdnckljasndkjcnaskjdnckjasndkljcnalkjsndclkjasndlkjcnalskjdnckjasndklcnalskdnclkjasndckljasndmasdlkcmalskdmclaksdmclaksdcmlkasmafsdklcaksdmcklaslkdmclkasmdlkcmaklsdmclkasmdlckmaslkdcmlaksdmcklamsldkcml;aksdmcklmaslkdcmlk;asmdlkcmlaksdmcklmaslkdcmlkasdmklcmlaksdmclkasmdlkcmal;skdcmlkascmlkaslkamsdlkcmals;kdmcl;kasmdlckmal;ksdcmlaksml;kasmdclkamlkamsdlkcmlaksdmclkasmdckl";
    
    textView.frame = CGRectMake(50, 70, 250, 100);
    
    textView.backgroundColor = [UIColor redColor];
    
    textView.inputView = [[UIView alloc] init];
    
    textView.delegate = self;
    
    [self.view addSubview:textView];
    
}

- (void)demo02
{
    UIView *view1 = [[UIView alloc] init];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIControl *control = [[UIControl alloc] init];
    
    [self.view addSubview:view1];
    
    [self.view insertSubview:button aboveSubview:control];
    
    [self.view bringSubviewToFront:button];
    
    [self.view addSubview:control];
    
    NSLog(@"%@",self.view.subviews);
    
    [self.view addSubview:button];
    
    NSLog(@"%@",self.view.subviews);
    
    [self.view addSubview:view1];
    
    NSLog(@"%@",self.view.subviews);
    
    UIView *tmpNil = nil;
    
    [self.view addSubview:tmpNil];
    
    NSLog(@"end");
}

- (void)demo01
{
    FSBaseView *redView = [[FSBaseView alloc] init];
    
    CGFloat width = 200;
    
    CGFloat x = (self.view.bounds.size.width - width) * 0.5;
    
    redView.frame = CGRectMake(x, 100, width, 300);
    
    redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:redView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    
    [redView addGestureRecognizer:panGesture];
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture
{
    UIView *redView = gesture.view;
    
    CGPoint point = [gesture translationInView:self.view];
    
    CGSize redViewSize = redView.frame.size;
    
    redView.frame = CGRectMake(point.x, point.y, redViewSize.width, redViewSize.height);
}

- (void)demoTextField
{
    UITextField *tf = [[UITextField alloc] init];
    
    tf.frame = CGRectMake(50, 100, self.view.bounds.size.width - 100, 35);
    
    tf.backgroundColor = [UIColor redColor];
    
    tf.placeholder = @"abcdefghijklmnopqrstuvwxyz11111";
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    
    tf.leftView = leftView;
    
    tf.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 5)];
    
    tf.rightView = rightView;
    
    tf.rightViewMode = UITextFieldViewModeWhileEditing;
    
    [self.view addSubview:tf];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
