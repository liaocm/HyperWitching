//
//  MHWDriver.m
//  HyperWitching
//

#import "MHWDriver.h"

@implementation MHWDriver
{
  NSTimer *_speedupEventLoop;
  NSInteger _toggle;
}

+ (instancetype)get
{
  static MHWDriver *shared = nil;
  static dispatch_once_t token;
  dispatch_once(&token, ^{
    shared = [[MHWDriver alloc] init];
    shared->_toggle = 0;
  });
  return shared;
}

+ (void)speedup
{
  MHWDriver *instance = [MHWDriver get];
  instance->_toggle += 1;
  instance->_toggle %= 4;
  [instance _speedup];
}

+ (NSString *)state
{
  MHWDriver *instance = [MHWDriver get];
  NSInteger toggle = instance->_toggle;
  if (toggle == 0) {
    return @"Stopped";
  } else if (toggle == 1) {
    return @"Fast";
  } else if (toggle == 2) {
    return @"Faster";
  } else {
    return @"HyperWitching";
  }
}

- (CGFloat)_getSpeedupInterval
{
  if (_toggle == 0) {
    return 0;
  } else if (_toggle == 1) {
    return 0.3f;
  } else if (_toggle == 2) {
    return 0.1f;
  } else {
    return 0.03f;
  }
}

- (void)_speedup
{
  CGFloat interval = [self _getSpeedupInterval];
  if (_speedupEventLoop) {
    [_speedupEventLoop invalidate];
  }
  if (interval == 0) {
    _speedupEventLoop = nil;
  } else {
    __weak __typeof(self) weakSelf = self;
    _speedupEventLoop =
    [NSTimer scheduledTimerWithTimeInterval:interval
                                    repeats:YES
                                      block:^(NSTimer * _Nonnull timer) {
      [weakSelf _doSpeedup];
    }];
  }
}

// This is kind of stupid, but it works.
// When an EAGLView is requested to re-layout,
// it'll reflow the whole rendering and discard the
// rendering speed settings for a brief moment. This
// speeds things up.
- (void)_doSpeedup
{
  [self.rootView setNeedsLayout];
}

@end

