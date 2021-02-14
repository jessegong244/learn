//
//  AViewController.m
//  learnProject
//
//  Created by 龚伟强 on 2020/12/22.
//

#import "AViewController.h"

@interface AViewController ()

@property (nonatomic,strong) NSTimer *myTimer;

@property (nonatomic,assign) NSInteger count;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
    __weak typeof (AViewController *)weakSelf = self;
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof (AViewController *)strongSelf = weakSelf;
        strongSelf.count ++;
        NSLog(@"count = %ld",strongSelf.count);
    }];
}

- (void)action{
    self.count ++;
    NSLog(@"count = %ld",self.count);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.myTimer invalidate];
//    self.myTimer = nil;
}

- (void)dealloc
{
    [self.myTimer invalidate];
    self.myTimer = nil;
    NSLog(@"dealloc");
    
}

@end
