//
//  ViewController.m
//  learnProject
//
//  Created by gwq on 2020/10/26.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"xixi");
    
    [self doSomething0];
}

- (void)doSomething0{
    //同步执行 + 串行队列
    //不会开启新线程，所有的任务都在主线程中执行。因为串行队列的原因，任务会按顺序执行。
    
    
    
    
    
    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue",DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"1");// 任务1
    dispatch_sync(queue,^{
        sleep(1);
        NSLog(@"2");// 任务2
//        dispatch_sync(queue,^{
//            NSLog(@"3");// 任务3
//        });
//        NSLog(@"4");// 任务4
    });
    sleep(0);
    NSLog(@"5");// 任务5
}
- (void)doSomething1{
    /*
     同步执行 + 并行队列
     虽然是并行队列，但是因为是同步执行，所以不会开启新线程。因为没有开启新线程，所以所有任务都在主线程执行，所以即使是并行队列，任务也需要按顺序依次执行。*/
    dispatch_queue_t queue = dispatch_queue_create("gongwh", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(queue, ^{
        sleep(3);
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        sleep(3);
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        sleep(3);
        NSLog(@"3----%@",[NSThread currentThread]);
    });
}
- (void)doSomething2{
    /*异步执行 + 串行队列
     因为是异步执行，所以开启了新的线程，因为是串行队列，所以任务在新的线程中按顺序执行。*/
    dispatch_queue_t queue = dispatch_queue_create("gongwh", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"3----%@",[NSThread currentThread]);
    });
}
- (void)doSomething3{
    /*异步执行 + 并行队列
     因为是异步执行，所以开启了新的线程，因为是并行队列，所以任务可以不按顺序执行。因此在这种组合模式下，可以开启多条线程。*/
    dispatch_queue_t queue = dispatch_queue_create("gongwh", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"3----%@",[NSThread currentThread]);
    });
}

- (void)doSomething4{
    /*异步执行 + 主队列
     虽然是异步执行，但是主队列中的任务是在主线程中执行，因此没有开启新的线程执行任务，任务按顺序执行。*/
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"3----%@",[NSThread currentThread]);
    });
}
- (void)doSomething5{
    /**/
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"2----%@",[NSThread currentThread]);
    });

    
}

@end
