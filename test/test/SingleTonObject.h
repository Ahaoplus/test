//
//  SingleTonObject.h
//  test
//
//  Created by 张浩 on 2017/2/23.
//  Copyright © 2017年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleTonObject : NSObject
//单例方法
+(instancetype)sharedInstance;
@end
