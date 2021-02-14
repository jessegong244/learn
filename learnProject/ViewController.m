//
//  ViewController.m
//  learnProject
//
//  Created by gwq on 2020/10/26.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "Animal.h"
#import "AViewController.h"
//#import "Animal+eat.h"
//#import "Dog.h"

@interface ViewController ()

@end



@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
//    [self test01];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 40)];
    [btn setTitle:@"OK" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction{
    AViewController *vc = [AViewController new];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)test01{
    dispatch_queue_t workQueue = dispatch_queue_create("workQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serielQueue = dispatch_queue_create("serielQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);
    for (int i = 0; i < 10; i ++) {
        dispatch_async(serielQueue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            dispatch_async(workQueue, ^{
                NSLog(@"thread info:%@,开始执行任务%d",[NSThread currentThread],i);
                sleep(3);
                NSLog(@"thread info:%@,结束执行任务%d",[NSThread currentThread],i);
                dispatch_semaphore_signal(semaphore);
            });
            
        });
    }
}

- (void)doSomeThing00{
    Class class = [self class];
    
    int string = objc_getClassList(&class, 100);
    
    
    
    NSLog(@"log:%d",string);
}

- (void)doSomething0{
    //同步执行 + 串行队列
    //不会开启新线程，所有的任务都在主线程中执行。因为串行队列的原因，任务会按顺序执行。
    dispatch_queue_t queue = dispatch_queue_create("xixi", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue,^{
        NSLog(@"1---%@",[NSThread currentThread]);// 任务1
    });

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
