//
//  NSTimer+EOCBlockSupport.m
//  invest
//
//  Created by lanjing on 6/14/16.
//  Copyright © 2016 yingzt. All rights reserved.
//

#import "NSTimer+EOCBlockSupport.h"

@implementation NSTimer(EOCBlockSupport)

+ (NSTimer *)eoc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)())block
                                        repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(eoc_blockInvoke:)
                                       userInfo:[block copy] repeats:repeats];
}

+ (void)eoc_blockInvoke:(NSTimer *)timer{
    void (^block)() = timer.userInfo;
    if(block){
        block();
    }
}
@end
