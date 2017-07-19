//
//  SingleTonObject.m
//  test
//
//  Created by 张浩 on 2017/2/23.
//  Copyright © 2017年 com. All rights reserved.
//

#import "SingleTonObject.h"

@implementation SingleTonObject
static id _instance;

+ (SingleTonObject *)sharedInstance
{
    static SingleTonObject *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SingleTonObject alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}


//单例方法
+(instancetype)sharedSingleton{
    return [[self alloc] init];
}
////alloc会调用allocWithZone:
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    //只进行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
//初始化方法
- (instancetype)init{
    // 只进行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}
//copy在底层 会调用copyWithZone:
- (id)copyWithZone:(NSZone *)zone{
    return  _instance;
}
+ (id)copyWithZone:(struct _NSZone *)zone{
    return  _instance;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}
@end
