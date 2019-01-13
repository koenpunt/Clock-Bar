// Clock Bar - Copyright © 2019 Nihalsharma. All rights reserved.

#import "ClockView.h"
@import QuartzCore;

#import <tgmath.h>

dispatch_source_t CreateDispatchTimer(uint64_t interval,
                                      uint64_t leeway,
                                      int64_t delta,
                                      dispatch_queue_t queue,
                                      dispatch_block_t block)
{
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                                     0, 0, queue);
    if (timer)
    {
        dispatch_time_t start = dispatch_walltime(NULL, delta);
        dispatch_source_set_timer(timer, start, interval, leeway);
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    return timer;
}


@interface ClockView ()

@property CATextLayer *text;

@end

@implementation ClockView {
    dispatch_source_t _timer;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupLayers];
        [self startTimer];
    }
    return self;
}

- (void)setupLayers {
    self.wantsLayer = YES;

    _text = [CATextLayer new];
    _text.fontSize = 12.f;
    _text.foregroundColor = [[NSColor whiteColor] CGColor];
    _text.contentsScale = [[NSScreen mainScreen] backingScaleFactor];
    _text.alignmentMode = kCAAlignmentCenter;
    [self.layer addSublayer:_text];
}

- (void)startTimer {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"HH:mm";

    void (^updateTime)() = ^() {
        _text.string = [dateFormatter stringFromDate:[NSDate date]];
    };

    NSDate *date = [NSDate date];
    // calculate time until next minute
    float mod = (float)60 - fmod([date timeIntervalSince1970], (double)60);
    int64_t delta = mod * NSEC_PER_SEC;

    _timer = CreateDispatchTimer(60ull * NSEC_PER_SEC, NSEC_PER_SEC, delta, dispatch_get_main_queue(), updateTime);

    updateTime();
}

- (void)layout {
    _text.frame = self.bounds;
}

@end
