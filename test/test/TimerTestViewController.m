//
//  TimerTestViewController.m
//  test
//
//  Created by 张浩 on 2017/3/16.
//  Copyright © 2017年 com. All rights reserved.
//

#import "TimerTestViewController.h"
#import "model1.h"
#import "model2.h"

@interface TimerTestViewController (){
    __weak NSTimer* mytimer;
}

@end

@implementation TimerTestViewController
-(void)startAction{
    model1* obj1 =  [[model1 alloc]init];
    model2* obj2 = [[model2 alloc]init];
    __weak model1* weakobj1 = obj1;
    __weak model2* weakobj2 = obj2;
    //如果两者的pengyou属性都为强引用则会形成循环引用无法释放内存
    obj1.pengyou = obj2;
    obj2.pengyou = obj1;
    
    obj1 = nil;//强引用释放，weak引用自动置为nil
    weakobj2 = nil;
    NSLog(@"weakobj1 is %@",weakobj1);
    NSLog(@"obj2 is %@",obj2);
    
}
-(void)stopAction{
    [mytimer invalidate];
}
-(void)dealloc{
    [self stopAction];
    NSLog(@"dealloc...... \n");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak TimerTestViewController* weakSelf = self;
    
//    mytimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(startAction) userInfo:nil repeats:YES];
    
    mytimer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer* timer){
    
        NSLog(@"timer is......%@ \n",timer);
        [weakSelf startAction];
        NSLog(@"timer is......%@ \n",timer);

    }];
    NSLog(@"mytimer is......%@ \n",mytimer);
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [mytimer invalidate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
