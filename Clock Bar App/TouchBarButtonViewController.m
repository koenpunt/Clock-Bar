// Clock Bar - Copyright © 2019 Nihalsharma. All rights reserved.

#import "TouchBarButtonViewController.h"
#import "TouchBarButtonView.h"

@import IOKit.ps;

void powerSourceChanged(void *context) {
    TouchBarButtonViewController *viewController = (__bridge TouchBarButtonViewController*)context;
    [viewController handlePowerSourceChange];
}

@interface TouchBarButtonViewController ()

@property TouchBarButtonView *view;

@end

@implementation TouchBarButtonViewController

@dynamic view;

- (void)loadView {
    self.view = [TouchBarButtonView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self monitorPowerSource];
    [self handlePowerSourceChange];
}

- (void)updateBatteryLevel:(CGFloat)batteryLevel {
    [self.view setBatteryLevel:batteryLevel];
}

- (void)monitorPowerSource {
    id context = self;
    // TODO fix argument type warning
    CFRunLoopSourceRef ref = IOPSNotificationCreateRunLoopSource(powerSourceChanged, (__bridge void *)(context));
    CFRunLoopAddSource(CFRunLoopGetCurrent(), ref, kCFRunLoopDefaultMode);
}

- (void)handlePowerSourceChange {
    CFTypeRef info = IOPSCopyPowerSourcesInfo();
    CFArrayRef list = IOPSCopyPowerSourcesList(info);
    CFTypeRef ps = CFArrayGetValueAtIndex(list, 0);

    // TODO use IOPSGetProvidingPowerSourceType to determine source, and decide if percentage should be shown

    CFDictionaryRef desc = IOPSGetPowerSourceDescription(info, ps);

    NSDictionary *dict = CFBridgingRelease(desc);

    // Find other keys in IOPSKeys.h
    float maxCapacity = [dict[@kIOPSMaxCapacityKey] floatValue];
    float capacity = [dict[@kIOPSCurrentCapacityKey] floatValue];

    NSLog(@"%@", dict);

    [self updateBatteryLevel:roundf(capacity / maxCapacity * 100)];
}

@end
