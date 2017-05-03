//
//  ViewController.m
//  RunLoopStudy
//
//  Created by syl on 2017/5/2.
//  Copyright © 2017年 personCompany. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加监听者
    [self addObserver];
}
/*
 当App程序启动的时候, RunLoop会进入UIInitializationRunLoopMode模式, 这时在处理UI的准备工作
 随后RunLoop会进入工作
 在即将处理事件的时候, RunLoop会从休眠中被唤醒, 进入被唤醒的状态kCFRunLoopAfterWaiting
 然后会第一时间处理Timer的事件
 处理之后, 查看是否还有Timer需要处理
 然后检查是否还有Source需要处理
 这时没有事件需要处理, 则准备进行休眠, 并且进行休眠
 当Timer再次触发时, RunLoop被唤醒, 并继续进行上面的步骤
 
 注意点：
 如果在Timer运行的过程中, 监听到Source事件, 比如触摸屏幕
 这时RunLoop会被唤醒, 然后处理Source事件, 并且之后再次进行上面的步骤, 直到休眠, 再次被唤醒
 */

-(void)addObserver
{
    //创建Runloop的监听者
   CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities,YES,0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
       //监听Runloop的状态
       switch (activity)
       {
           case kCFRunLoopEntry:
               NSLog(@"Runloop 进入");
               break;
            case kCFRunLoopBeforeTimers:
               NSLog(@"Runloop 即将处理Timer事件");
               break;
            case kCFRunLoopBeforeSources:
               NSLog(@"Runloop 即将处理Source事件");
               break;
            case kCFRunLoopBeforeWaiting:
               NSLog(@"Runloop 即将进入休眠");
               break;
            case kCFRunLoopAfterWaiting:
               NSLog(@"Runloop 即将被唤醒");
           case kCFRunLoopExit:
               NSLog(@"Runloop 退出");
               break;
           default:
               break;
       }
   });
    //把监听者给指定的RunLoop
    CFRunLoopAddObserver(CFRunLoopGetCurrent(),observer, kCFRunLoopDefaultMode);
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"currentRunLoopModel:%@",[NSRunLoop currentRunLoop].currentMode);
    }];
    /*出发timer 事件后，可以看到runLoop背重新唤醒，接着执行Timer，Source 在到休眠*/
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
