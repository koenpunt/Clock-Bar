// Clock Bar - Copyright © 2019 Nihalsharma. All rights reserved.

#import "BatteryView.h"
@import QuartzCore;

@interface BatteryView ()

@property (nonatomic) CGFloat batteryLevel;
@property NSTextField *label;
@property CALayer *bar;
@property CALayer *textBar;
@property CATextLayer *text;
@property CATextLayer *textMask;

@end

@implementation BatteryView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _batteryLevel = 100.f;
        [self setupLayers];
    }
    return self;
}

- (void)setupLayers {
    self.wantsLayer = YES;

    CATransform3D textRotation = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(M_PI_2));

    _text = [CATextLayer new];
    _text.fontSize = 9.f;
    _text.foregroundColor = [[NSColor whiteColor] CGColor];
    _text.contentsScale = [[NSScreen mainScreen] backingScaleFactor];
    _text.alignmentMode = kCAAlignmentCenter;
    _text.transform = textRotation;
    [self.layer addSublayer:_text];

    _textMask = [CATextLayer new];
    _textMask.fontSize = 9.f;
    _textMask.foregroundColor = [[NSColor whiteColor] CGColor];
    _textMask.contentsScale = [[NSScreen mainScreen] backingScaleFactor];
    _textMask.alignmentMode = kCAAlignmentCenter;
    _textMask.transform = textRotation;

    _bar = [CALayer new];
    _bar.backgroundColor = [[NSColor greenColor] CGColor];
    [self.layer addSublayer:_bar];

    _textBar = [CALayer new];
    _textBar.backgroundColor = [[NSColor blackColor] CGColor];
    _textBar.mask = _textMask;
    [self.layer addSublayer:_textBar];
}


- (void)setBatteryLevel:(CGFloat)batteryLevel {
    _batteryLevel = batteryLevel;

    NSString *string = [NSString stringWithFormat:@"%.f%%", _batteryLevel];

    _text.string = string;
    _textMask.string = string;

    if (_batteryLevel < 10.f) {
        _bar.backgroundColor = [[NSColor redColor] CGColor];
    } else if (_batteryLevel < 20.f) {
        _bar.backgroundColor = [[NSColor orangeColor] CGColor];
    } else {
        _bar.backgroundColor = [[NSColor greenColor] CGColor];
    }

    [self setNeedsDisplay:YES];
    [self displayIfNeeded];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSRect frame = self.bounds;
    frame.size.height = frame.size.height / 100.f * _batteryLevel;
    _bar.frame = frame;
    _textBar.frame = frame;
    _text.frame = self.bounds;
    _textMask.frame = self.bounds;
}

@end
