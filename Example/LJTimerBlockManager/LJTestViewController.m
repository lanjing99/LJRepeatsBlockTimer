//
//  LJTestViewController.m
//  LJTimerBlockManager
//
//  Created by 陈文经 on 7/19/16.
//  Copyright © 2016 lanjing. All rights reserved.
//

#import "LJTestViewController.h"
#import "NSTimer+EOCBlockSupport.h"
#import "LJRepeatsBlockTimer.h"

@interface LJTestViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) LJRepeatsBlockTimer *blockTimer;


@end

@implementation LJTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak __typeof(self) weakSelf = self;
//    self.timer = [NSTimer eoc_scheduledTimerWithTimeInterval:1 block:^{
//        [weakSelf timerTrigger:weakSelf.timer];
//    } repeats:YES];
    
    self.blockTimer = [LJRepeatsBlockTimer scheduledTimerWithTimeInterval:1 block:^{
        static int count = 0;
        NSLog(@"time block count %d times", ++count);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)timerTrigger:(NSTimer *)timer{
    NSLog(@"%@", self);
}


- (void)dealloc{
//  [self.timer invalidate];
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
