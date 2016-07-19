//
//  LJBlockTimer.h
//  LJTimerBlockManager
//
//  Created by 陈文经 on 7/19/16.
//  Copyright © 2016 lanjing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJRepeatsBlockTimer : NSObject

@property (nonatomic, strong, readonly) NSTimer *timer;
@property (nonatomic, copy, readonly) dispatch_block_t block;

+ (LJRepeatsBlockTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(dispatch_block_t)block;

- (instancetype)initWithBlock:(dispatch_block_t)block interval:(NSTimeInterval)interval;

@end
