//
//  FSBitImage.h
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/10/17.
//  Copyright © 2018年 付森. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct FSPixelSize{
 
    /// 水平方向上的像素个数
    NSUInteger horizontal;
    /// 垂直方向上的像素个数
    NSUInteger vertical;
    
} FSPixelSize;

@interface FSBitImage : NSObject


/**
 像素数：在水平和垂直方向上分别有多少个像素点，形成一个矩阵，
 通常说的手机摄像头是多少万像素指镜头pixelSize.horizontal * pixelSize.vertical
 */
@property (nonatomic, assign) FSPixelSize pixelSize;

/*
 分辨率：
 分辨率是一个笼统的概念，在不同的语境代表不同的含义
 图片分辨率：
    1、图片分辨率指图片每英寸上的像素总数，单位ppi(像素每英寸) eg: 9 x 8 = 72ppi
    2、图片分辨率指一个完整的位图在水平和垂直方向上的像素量。表示为: horizontal x vertical. eg: 200 x 300 = 60000 pix
    3、图片分辨率指一个完整的位置在水平和垂直方向上的物理长度。表示为:  20 x 30 英寸
 屏幕分辨率：
    屏幕分辨率值屏幕的精密度，是说显示器所能显示的像素是多少。
    由于屏幕上的点、线和面都是由像素组成的，显示器可显示的像素越多，画面就越精细，同样的屏幕区域内能显示的信息也越多，所以分辨率是个非常重要的性能指标之一。
 */

/*
 图片物理尺寸拉伸：在位图像素总数不变的前提下，拉伸图片会使得每一个像素格子被拉大，每英寸上的像素量变少。图片变得模糊不清，有颗粒感
 图片物理尺寸缩小：1、减少总像素量，打印尺寸变小。2、增大每英寸内的像素总量，打印尺寸变小
 用compressionQuality属性压缩图片，会减少整个图片的分辨率
 */

/**
 文件大小，指在存储在磁盘上所需要的存储空间 单位：字节（byte）
 */
@property (nonatomic, assign) long long fileSize;


/**
 显示尺寸，一个图片在打印机和显示器上显示的尺寸大小
 */
@property (nonatomic, assign) CGSize showSize;


/**
 压缩质量 0.0 ~ 1.0
 */
@property (nonatomic, assign) CGFloat compressionQuality;


/**
 亮度
 */
@property (nonatomic, assign) NSUInteger brightness;



@end
