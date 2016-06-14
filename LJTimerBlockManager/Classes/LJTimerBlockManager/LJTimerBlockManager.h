//
//  TimerBlockManager.h
//  TimerBlockManager
//
//  Created by lanjing on 6/14/16.
//  Copyright © 2016 lanjing. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol LJTimerBlockItemProtocol <NSObject>

-(void)remove;

@end


/**
 *  use for manage multiple timer task, so user (mostly ViewControllers) do care about setting timmer
 */
@interface LJTimerBlockManager : NSObject

+(instancetype)shareInstance;

-(id<LJTimerBlockItemProtocol>)addTimerBlock:(dispatch_block_t)block forInterval:(NSTimeInterval)interval startImmediately:(BOOL)start;
-(id<LJTimerBlockItemProtocol>)addTimerBlock:(dispatch_block_t)block forInterval:(NSTimeInterval)interval;
-(void)removeTimerBlockItem:(id<LJTimerBlockItemProtocol>)item;

@end
