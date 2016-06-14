//
//  LJViewController.m
//  LJTimerBlockManager
//
//  Created by lanjing on 06/14/2016.
//  Copyright (c) 2016 lanjing. All rights reserved.
//

#import "LJViewController.h"
#import "LJTimerBlockManager.h"

@interface LJViewController ()
@property (nonatomic, strong) id<LJTimerBlockItemProtocol> item;
@end

@implementation LJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.item = [[LJTimerBlockManager shareInstance] addTimerBlock:^{
        NSLog(@"I am here");
    } forInterval:1 startImmediately:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTouched:(id)sender {
    [self.item remove];
}

@end
