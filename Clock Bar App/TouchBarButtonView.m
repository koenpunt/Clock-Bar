// Clock Bar - Copyright © 2019 Nihalsharma. All rights reserved.

#import "TouchBarButtonView.h"
#import "BatteryView.h"
#import "ClockView.h"

@implementation TouchBarButtonView {
    BatteryView *_batteryView;
    ClockView *_clockView;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];

    if (self) {
        [self setupViews];
        [self setupConstraints];
    }

    return self;
}

- (void)setupViews {
    _batteryView = [BatteryView new];
    [self addSubview:_batteryView];

    _clockView = [ClockView new];
    [self addSubview:_clockView];
}

- (void)setupConstraints {
    _batteryView.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:
     @[
       [_batteryView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
       [_batteryView.topAnchor constraintEqualToAnchor:self.topAnchor],
       [_batteryView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
       [_batteryView.widthAnchor constraintEqualToConstant:12.f]]
     ];
}

- (void)layout {
    [super layout];

    CGFloat touchBarButtonBorder = 2.f;

    CGRect clockFrame = self.bounds;
    clockFrame.size.height = clockFrame.size.height;
    clockFrame.size.width = clockFrame.size.width - 12.f - touchBarButtonBorder;
    clockFrame.origin.x = 12.f;
    clockFrame.origin.y = 0;

    _clockView.frame = clockFrame;
}

- (void)setBatteryLevel:(CGFloat)batteryLevel {
    [_batteryView setBatteryLevel:batteryLevel];
}

@end
