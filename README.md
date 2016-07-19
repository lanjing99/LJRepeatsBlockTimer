# LJRepeatsBlockTimer

[![CI Status](http://img.shields.io/travis/lanjing/LJTimerBlockManager.svg?style=flat)](https://travis-ci.org/lanjing/LJTimerBlockManager)
[![Version](https://img.shields.io/cocoapods/v/LJTimerBlockManager.svg?style=flat)](http://cocoapods.org/pods/LJTimerBlockManager)
[![License](https://img.shields.io/cocoapods/l/LJTimerBlockManager.svg?style=flat)](http://cocoapods.org/pods/LJTimerBlockManager)
[![Platform](https://img.shields.io/cocoapods/p/LJTimerBlockManager.svg?style=flat)](http://cocoapods.org/pods/LJTimerBlockManager)

##使用说明
在应用中经常要使用定时器功能。通常会在ViewController中创建和销毁时器。

NSTimmer的实现原理，具体参考NSTimer的类参考
1）NSTimer给予runloop实现，它不是精确的，实时的机制。精度一般在50-100ms之间。
2）如果定时器的时间到了，但是runloop正在处理其他事情，不会触发定时器操作。等待下次到来。

NSTimer的使用注意一个问题
在调用+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
target:(id)target
selector:(SEL)aSelector
userInfo:(id)userInfo
repeats:(BOOL)repeats方法时，
runloop持有NSTimer对象，Timer对象又持有target，（一般是在VC），所以在VC的dealloc中调用[timer invalidate]是无效的。如果VC也持有了返回的NSTimer对象，会造成retain cycle。
参考Effective Objective-C 2.0书中的代码，这类实现了NSTimer的EOCBlockSupport category，在这个分类中，NSTimer对象持有了self，此时在静态方法中的self是一个class对象，而不是持有原来的VC对象，所以不会造成retain cycle。 所以可以在VC的dealloc中调用[timer invalidate]方法。invalidate方法还是要调用的，因为runloop持有了timer，不调用就会一直执行。

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

LJRepeatsBlockTimer中使用了NSTimer，在dealloc中，调用Timer的invalidate方法。

## Example

self.blockTimer = [LJRepeatsBlockTimer scheduledTimerWithTimeInterval:1 block:^{
static int count = 0;
NSLog(@"time block count %d times", ++count);
}];

## Requirements

## Installation

LJTimerBlockManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LJTimerBlockManager"
```

## Author

lanjing, 84336951@qq.com

## License

LJTimerBlockManager is available under the MIT license. See the LICENSE file for more info.
