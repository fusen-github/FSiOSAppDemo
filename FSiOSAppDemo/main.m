//
//  main.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/8/20.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

/*
 UIApplicationMain函数的官方文档注释:
 Creates the application object and the application delegate and sets up the event cycle.
 This function instantiates the application object from the principal class and instantiates the delegate (if any) from the given class and sets the delegate for the application. It also sets up the main event loop, including the application’s run loop, and begins processing events. If the application’s Info.plist file specifies a main nib file to be loaded, by including the NSMainNibFile key and a valid nib file name for the value, this function loads that nib file.
 Despite the declared return type, this function never returns. For more information on how this function behaves, see “Expected App Behaviors” in App Programming Guide for iOS.
 
 翻译:
 1、UIApplicationMain函数创建应用程序实例(UIApplication单例对象),
 2、创建AppDelegate实例
 3、设置UIApplication对象的代理为AppDelegate实例
 4、设置事件循环，开启主运行循环.每当监听到对应的系统事件，就会通知AppDelegate
 5、UIApplicationMain函数永远不会返回
 
 此函数实例化来自主体类的应用程序对象，并实例化来自给定类的委托(如果有的话)，并为应用程序设置委托。它还设置主事件循环，包括应用程序的运行循环，并开始处理事件。如果应用程序的信息。plist文件指定要加载的主nib文件，通过包含NSMainNibFile键和值的有效nib文件名，该函数加载nib文件。
 
 尽管声明了返回类型，但这个函数永远不会返回。有关此功能的更多信息，请参阅iOS应用程序编程指南中的“预期应用程序行为”。
 
 */

/*
 程序启动逻辑：
 使用Xcode打开一个项目，很容易会发现一个文件－－main.m文件，此处就是应用的入口了。
 程序启动时，先执行main函数，main函数是ios程序的入口点，内部会调用UIApplicationMain函数，
 UIApplicationMain里会创建一个UIApplication对象 ，然后创建UIApplication的delegate对象 —–（您的）AppDelegate ，
 开启一个消息循环（main runloop），每当监听到对应的系统事件时，就会通知AppDelegate。
 
 UIApplication对象是应用程序的象征，每一个应用都有自己的UIApplication对象，而且是单例的。
 通过[UIApplication sharedApplication]可以获得这个单例对象，
 一个iOS程序启动后创建的第一个对象就是UIApplication对象， 利用UIApplication对象，能进行一些应用级别的操作。
 */

/*
 UIApplicationMain函数实现如下：
 int UIApplicationMain
 {
    int argc,
    char *argv[],
    NSString *principalClassName,
    NSString * delegateClassName
 }
 
 第一个参数表示参数的个数，
 第二个参数表示装载函数的数组，
 第三个参数，是UIApplication类名或其子类名，若是nil，则默认使用UIApplication类名。
 第四个参数是协议UIApplicationDelegate的实例化对象名，这个对象就是UIApplication对象监听到系统变化的时候通知其执行的相应方法。
 
 参考文献:
 http://www.cocoachina.com/ios/20161114/18054.html
 https://www.jianshu.com/p/231b1cebf477
 
 */
