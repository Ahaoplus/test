//
//  view222.m
//  test
//
//  Created by 张浩 on 2017/2/20.
//  Copyright © 2017年 com. All rights reserved.
//

#import "view222.h"

@implementation view222

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSLog(@"%f,%f,%f,%f",self.layer.anchorPoint.x,self.layer.anchorPoint.y,self.layer.position.x,self.layer.position.y);
        self.layer.anchorPoint = CGPointMake(0.1, 0.1);
        self.layer.position = CGPointMake(200, 200);
    }
    return self;
}
//时间的响应是逐层向上传递的
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
//    UIResponder * next = [self nextResponder];
//    NSMutableString * prefix = @"".mutableCopy;
//    
//    while (next != nil) {
//        NSLog(@"%@%@", prefix, [next class]);
//        [prefix appendString: @"--"];
//        next = [next nextResponder];
//    }
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}
//recursively calls -pointInside:withEvent:. point is in the receiver's coordinate system
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //如果- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event函数返回YES则view为nil
    UIView *view = [super hitTest:point withEvent:event];
    int i = 0;
    if (view == nil ) {
        //遍历当前view的subView，看一下被触摸的点是否在subView上
        if (self.subviews.count>0) {
            for (UIView *subView in self.subviews) {
                CGPoint tp = [subView convertPoint:point fromView:self];
                if (CGRectContainsPoint(subView.bounds, tp)) {
                    view = subView;
                    NSLog(@"%d-------------+++++++++++++++++++++%@",i,subView);
                }
                i++;
            }
        }
        NSLog(@"%d-------------+++++++++++++++++++++self is %@ event is %@",i,self,event);
    }else{
        NSLog(@"%d-----not null--------%@ event is %@",i,self,event);
    }
    //如果为nil则认为当前view和其subview都不包含被触碰的点
    
    return view;
}
/*
 如果返回yes则认为触发事件的点在当前view内，因为事件的传递是自下而上的superView-subView这样一层层传递的，当我们点击当前view的superView的时候，当事件传递到superView还会向上传递，并通过此函数进行判断（其实在一层层传递过程中都是通过此函数进行判断的），如果返回YES则在此View上也能接收到事件。
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    //if内的条件应该为，当触摸点point超出蓝色部分，但在黄色部分时
    //此处可以加一些自己的的判断条件
    BOOL inside = [super pointInside:point withEvent:event];
    return inside;
//    if (YES){
//        return YES;
//    }
//    return NO;
}
@end
