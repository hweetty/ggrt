//
//  AppDelegate.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "AppDelegate.h"
#import "StatusMenuController.h"
#import "PollPushManager.h"

@interface AppDelegate () {
	StatusMenuController *_controller;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	[self.statusItem setMenu:self.statusMenu];
	[self.statusMenu setDelegate:self];
	
	_controller = [[StatusMenuController alloc] initWithMenu:self.statusMenu item:self.statusItem];
	
	[PollPushManager start];
}

- (void)menuWillOpen:(NSMenu *)menu {
	[[NSNotificationCenter defaultCenter] postNotificationName:kTheMenuWillOpenNotification object:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

@end
