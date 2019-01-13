#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSMenu *statusMenu;
@property (strong, nonatomic) NSStatusItem *statusBar;

@property (strong, nonatomic) IBOutlet NSMenuItem *prefsMenuItem;
@property (strong, nonatomic) IBOutlet NSMenuItem *quitMenuItem;

- (IBAction)prefsMenuItemAction:(id)sender;
- (IBAction)quitMenuItemAction:(id)sender;

@end

