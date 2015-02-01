//
//  AddMenuView.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "AddMenuView.h"

@implementation AddMenuView

- (void)focusTextfield {
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
		if (!self.window) {
			[self focusTextfield];
			return;
		}
		
		// Cannot focus textfield the second time. Must restart app. Use NSWindow later?
		// CarbonWindows are a problem. http://stackoverflow.com/q/5150014
		[self.window makeFirstResponder:self.routeTextfield];
	});
}

- (void)style {
	[super style];
	
	[self focusTextfield];
}

- (void)controlTextDidChange:(NSNotification *)obj {
	
}

@end
