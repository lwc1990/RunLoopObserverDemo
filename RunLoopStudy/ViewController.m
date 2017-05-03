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
-(void)addObserver
{
    //创建Runloop的监听者
   CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities,YES,0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
       //静听Runloop的状态
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
               NSLog(@"Runloop 推出");
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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
