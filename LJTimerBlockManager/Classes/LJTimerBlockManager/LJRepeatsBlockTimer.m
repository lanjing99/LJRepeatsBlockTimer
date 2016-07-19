//
//  LJBlockTimer.m
//  LJTimerBlockManager
//
//  Created by 陈文经 on 7/19/16.
//  Copyright © 2016 lanjing. All rights reserved.
//

#import "LJRepeatsBlockTimer.h"
#import "NSTimer+EOCBlockSupport.h"

@implementation LJRepeatsBlockTimer

@synthesize timer = _timer, block = _block;

+ (LJRepeatsBlockTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(dispatch_block_t)block{
    return [[self alloc] initWithBlock:block interval:interval];
}
-(instancetype)initWithBlock:(dispatch_block_t)block interval:(NSTimeInterval)interval
{
    if(self = [super init]){
        _block = [block copy];
        _timer = [NSTimer eoc_scheduledTimerWithTimeInterval:interval block:block repeats:YES];
        _block();
    }
    return self;
}


-(void)dealloc
{
    [self.timer invalidate];
}

@end
