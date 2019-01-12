// Clock Bar - Copyright © 2019 Nihalsharma. All rights reserved.

#import "TouchBarButtonView.h"
#import "BatteryView.h"

@interface ColoredView : NSView

@property NSColor *backgroundColor;

@end

@implementation ColoredView

- (instancetype)initWithBackgroundColor:(NSColor *)backgroundColor {
    self = [super init];
    if (self) {
        _backgroundColor = backgroundColor;
    }
    return self;
}


- (void)drawRect:(NSRect)dirtyRect {
    [_backgroundColor setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end

@implementation TouchBarButtonView {
    BatteryView *_batteryView;
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

- (void)setBatteryLevel:(CGFloat)batteryLevel {
    [_batteryView setBatteryLevel:batteryLevel];
}

@end
