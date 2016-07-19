//
//  TimerBlockManager.m
//  TimerBlockManager
//
//  Created by lanjing on 6/14/16.
//  Copyright © 2016 lanjing. All rights reserved.
//

#import "LJTimerBlockManager.h"
#import "NSTimer+EOCBlockSupport.h"
#import <libkern/OSAtomic.h>

@interface LJTimerBlockItem : NSObject <LJTimerBlockItemProtocol>

@property (nonatomic, weak) LJTimerBlockManager *timerBlockManager;
@property (nonatomic, strong, readonly) NSTimer *timer;
@property (nonatomic, copy, readonly) void(^block)();

-(instancetype)initWithBlock:(dispatch_block_t)block interval:(NSTimeInterval)interval;

@end


@implementation LJTimerBlockItem
@synthesize timer = _timer, block = _block;



-(instancetype)initWithBlock:(dispatch_block_t)block interval:(NSTimeInterval)interval
{
    if(self = [super init]){
        _block = [block copy];
        _timer = [NSTimer eoc_scheduledTimerWithTimeInterval:interval block:block repeats:YES];
    }
    return self;
}

-(void)remove
{
    [self.timer invalidate];
    [self.timerBlockManager removeTimerBlockItem:self];
}


-(void)dealloc
{
    [self remove];
}

@end




@interface LJTimerBlockManager ()



@property (nonatomic, strong, readonly) NSMutableArray *timerBlockItems;

@end

@implementation LJTimerBlockManager
@synthesize timerBlockItems = _timerBlockItems;

+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static id shareInstace;
    dispatch_once(&onceToken, ^{
        shareInstace = [[LJTimerBlockManager alloc] init];
    });
    return shareInstace;
}

/**
 *  Add a block and its repeat interval to LJTimerBlockManager, so this block can be executed repeated
 *
 *  @param block    block contain certain task
 *  @param interval repeat interval in seconds
 *  @param start    if start immediately, default is YES
 *
 *  @return  An LJTimerBlockItem objects comforming to <LJTimerBlockItemProtocol>, which can cancel timer by invoke remove.
 */
-(id<LJTimerBlockItemProtocol>)addTimerBlock:(dispatch_block_t)block forInterval:(NSTimeInterval)interval startImmediately:(BOOL)start
{
    LJTimerBlockItem *item = [[LJTimerBlockItem alloc] initWithBlock:block interval:interval];
    item.timerBlockManager = self;
    if(start){
        block();
    }
    //use to protect timerBlockItems in multi threads.
    aspect_performLocked(^{
        [self.timerBlockItems addObject:item];
    });
    
    return item;
}

-(id<LJTimerBlockItemProtocol>)addTimerBlock:(dispatch_block_t)block forInterval:(NSTimeInterval)interval
{
    return [self addTimerBlock:block forInterval:interval startImmediately:YES];
}


-(void)removeTimerBlockItem:(id<LJTimerBlockItemProtocol>)item
{
    aspect_performLocked(^{
        [self.timerBlockItems removeObject:item];
    });
}

-(NSMutableArray *)timerBlockItems
{
    if(!_timerBlockItems)
    {
        _timerBlockItems = [[NSMutableArray alloc] init];
    }
    return _timerBlockItems;
}

static void aspect_performLocked(dispatch_block_t block) {
    static OSSpinLock aspect_lock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&aspect_lock);
    block();
    OSSpinLockUnlock(&aspect_lock);
}

@end











