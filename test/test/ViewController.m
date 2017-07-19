//
//  ViewController.m
//  test
//
//  Created by 张浩 on 2017/2/20.
//  Copyright © 2017年 com. All rights reserved.
//

#import "ViewController.h"
#import "view111.h"
#import "view222.h"
#import "TimerTestViewController.h"
#import <objc/runtime.h> //包含对类、成员变量、属性、方法的操作
#import <objc/message.h> //包含消息机制
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSDictionary* dic = nil;
    NSInteger code = [dic[@"code"] integerValue];
    if (code == 0) {
        NSLog(@"success");
    }
    NSArray* str1 = @[@1,@2,@3];
    NSArray* str2 = str1;
    NSArray* str3 = [str1 copy];
    NSArray* str4 = [str1 mutableCopy];
    NSLog(@"%@ %@ %@ %@",str1,str2,str3,str4);
    NSMutableArray* m_array = [NSMutableArray arrayWithArray:str1];
    [[NSUserDefaults standardUserDefaults] setObject:m_array forKey:@"array"];
    
    
    
    view222* view1 = [[view222 alloc]initWithFrame:CGRectMake(0, 0,300, 300)];
    view1.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view1];

    view111* view2 = [[view111 alloc]initWithFrame:CGRectMake(50, 50, 300, 300)];
    
    view2.backgroundColor = [UIColor yellowColor];
    
    [view1 addSubview:view2];
    
    
    view222* view3 = [[view222 alloc]initWithFrame:CGRectMake(0, 0,200, 200)];
    view3.backgroundColor = [UIColor blueColor];
    
    [view1 addSubview:view3];
    
    
//    [self testGDC_main_queue];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)testRuntime{
    /** 利用runtime遍历一个类的全部成员变量
     1.导入头文件<objc/runtime.h>     */
    unsigned int count = 0;
    /** Ivar:表示成员变量类型 */
    Ivar *ivars = class_copyIvarList([self.view class], &count);//获得一个指向该类成员变量的指针
    for (int i =0; i < count; i ++) {
        //获得Ivar
        Ivar ivar = ivars[i];        //根据ivar获得其成员变量的名称--->C语言的字符串
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"%d----%@",i,key);
    }
    
    
    view111* view2 = [[view111 alloc]initWithFrame:CGRectMake(0, 0, 350, 500)];
    count = 0;
    /** Ivar:表示成员变量类型 */
    objc_property_t *properties = class_copyPropertyList([view2 class], &count);//class_copyIvarList([self.view class], &count);//获得一个指向该类成员变量的指针
    for (int i =0; i < count; i ++) {
        //获得Ivar
        objc_property_t property = properties[i];        //根据ivar获得其成员变量的名称--->C语言的字符串
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"%d++++++%@",i,key);
    }

}
/**
    多线程编程：GCG
    所用函数：
    dispatch_get_main_queue();//返回dispatch_queue_t类型
    dispatch_get_global_queue(<#long identifier#>, <#unsigned long flags#>);//返回dispatch_queue_t类型
    dispatch_queue_create(<#const char * _Nullable label#>, <#dispatch_queue_attr_t  _Nullable attr#>);//返回dispatch_queue_t类型
    dispatch_sync(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>);
    dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>);
 
 */
-(void)testGDC_main_queue{
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //异步操作
//    dispatch_async(mainQueue, ^{
//        for (int i = 0; i<10; i++) {
//            NSLog(@"async+i=%d",i);
//        }
//    });
//    
//    dispatch_async(mainQueue, ^{
//        for (int j = 0; j<10; j++) {
//            NSLog(@"async+j=%d",j);
//        }
//    });
    
    
    dispatch_async(mainQueue, ^{
        for (int i = 0; i<10; i++) {
            NSLog(@"-----sync：：：：i=%d",i);
        }
    });
    UIView* view=nil;
    [view class];
    dispatch_async(mainQueue, ^{
        for (int j = 0; j<10; j++) {
            NSLog(@"async+j=%d",j);
        }
    });
}
-(void)testGDC_globle_queue{
    
    //并行队列
    dispatch_queue_t globleQueue = dispatch_get_global_queue(0,DISPATCH_QUEUE_PRIORITY_DEFAULT);
    
    //异步任务内套同步任务
    dispatch_async(globleQueue, ^{
        //同步任务
        dispatch_sync(globleQueue, ^{
            for (int i = 0; i<5; i++) {
                NSLog(@"-------sync+i=%d",i);
            }
        });
        
        dispatch_sync(globleQueue, ^{
            for (int j = 0; j<5; j++) {
                NSLog(@"-------sync+j=%d",j);
            }
        });
    });
    
    dispatch_async(globleQueue, ^{
        for (int j = 0; j<10; j++) {
            NSLog(@"async+j=%d",j);
        }
    });
}
- (IBAction)pushAction:(UIButton *)sender {
    TimerTestViewController* timerView = [[TimerTestViewController alloc]init];
    [self.navigationController pushViewController:timerView animated:YES];
}

-(void)testGCD_my_queue{
    //自定义并行队列
    dispatch_queue_t myqueue = dispatch_queue_create("Ahaoplus", DISPATCH_QUEUE_CONCURRENT);
    
    //异步任务执行
//    dispatch_async(myqueue, ^{
//        for (int i = 0; i<5; i++) {
//            NSLog(@"-------sync+i=%d",i);
//        }
//    });
//    
//    
//    dispatch_async(myqueue, ^{
//        for (int j = 0; j<5; j++) {
//            NSLog(@"async+j=%d",j);
//        }
//    });
    
    //同步任务
    dispatch_sync(myqueue, ^{
        for (int i = 0; i<5; i++) {
            NSLog(@"-------sync+i=%d",i);
        }
    });
    
    
    dispatch_sync(myqueue, ^{
        for (int j = 0; j<5; j++) {
            NSLog(@"async+j=%d",j);
        }
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
