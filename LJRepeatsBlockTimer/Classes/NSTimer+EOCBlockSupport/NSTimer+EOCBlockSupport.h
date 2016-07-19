//
//  NSTimer+EOCBlockSupport.h
//  invest
//
//  Created by lanjing on 6/14/16.
//  Copyright © 2016 yingzt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer(EOCBlockSupport)

+ (NSTimer *)eoc_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                          block:(void(^)())block
                                        repeats:(BOOL)repeats;

@end
