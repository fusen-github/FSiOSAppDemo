//
//  FSController19.m
//  FSiOSAppDemo
//
//  Created by 付森 on 2018/11/8.
//  Copyright © 2018年 付森. All rights reserved.
//

#import "FSController19.h"
#import <CoreMotion/CoreMotion.h>


@interface FSController19 ()

/**
 动作、运动、动机  动作事件管理器
 该对象不是一个单例，但是在一个app中应该只创建一个CMMotionManager对象。负责全局的运动管理
 */
@property (nonatomic, strong) CMMotionManager *motionManager;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

static NSString * NSStringFromCMRotationRate(CMRotationRate rate)
{
    return [NSString stringWithFormat:@"CMRotationRate is x: %.2lf, y: %.2lf, z: %.2lf",rate.x, rate.y, rate.z];
}

static NSString * NSStringFromCMAcceleration(CMAcceleration acceleration)
{
    return [NSString stringWithFormat:@"CMAcceleration is x: %.2lf, y: %.2lf, z: %.2lf",acceleration.x, acceleration.y, acceleration.z];
}

@implementation FSController19

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    
    self.motionManager = motionManager;
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    
    self.operationQueue = operationQueue;
    
    /// 设备运动是有效的
    if (motionManager.deviceMotionAvailable)
    {
        /// 更新运动状态的时间间隔
        motionManager.deviceMotionUpdateInterval = 1;
        
        /*
         CMDeviceMotion 一个动作对象
         */
        [motionManager startDeviceMotionUpdatesToQueue:operationQueue withHandler:^(CMDeviceMotion *motion, NSError *error) {
           
            NSLog(@"%@",[NSThread currentThread]);
            
            /// 陀螺仪数值。 表示在x、y、z轴上的旋转率
            CMRotationRate rate = motion.rotationRate;
            
            // CMAcceleration: 结构体描述x、y、z三个方向上的加速度
            
            /// 重力、地球引力  加速计
            CMAcceleration graity = motion.gravity;
            
            /// 用户给设备的加速度
            CMAcceleration userA = motion.userAcceleration;
            
            /// 设备的姿态(方位)
            CMAttitude *attitude = motion.attitude;
            
//            attitude.roll
            
//            attitude.pitch
            
//            attitude.yaw
            
            NSLog(@"转速 %@",NSStringFromCMRotationRate(rate));
            
            NSLog(@"地球引力 %@",NSStringFromCMAcceleration(graity));
            
            NSLog(@"用户加速度 %@",NSStringFromCMAcceleration(userA));
            
        }];
    }
    else
    {
        NSLog(@"无效");
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
}

@end
