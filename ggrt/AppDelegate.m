//
//  AppDelegate.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "AppDelegate.h"
#import "BusStatusItem.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	[self.statusItem setMenu:self.statusMenu];
	[self.statusItem setTitle:@"10m\n200"];
	
	NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:@"200\n10 mins"];
	NSRange range = NSMakeRange(0, as.length);
	[as addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:10] range:range];
	
	self.statusItem.attributedTitle = as;
	[self.statusItem setHighlightMode:YES];
	
	
	BusStatusItem *item1 = [self loadNibNamed:@"BusStatusCell"];
	[self.statusMenu addItem:item1];
	
	BusStatusItem *item2 = [self loadNibNamed:@"BusStatusCell"];
	[self.statusMenu addItem:item2];
}

- (id)loadNibNamed:(NSString *)name {
	NSArray *topLevelObjects;
	NSNib *nib = [[NSNib alloc] initWithNibNamed:name bundle:[NSBundle mainBundle]];
	[nib instantiateWithOwner:nil topLevelObjects:&topLevelObjects];

	for (id obj in topLevelObjects) {
		if ([obj isKindOfClass:[BusStatusItem class]]) {
			return obj;
		}
	}
	return nil;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

@end
