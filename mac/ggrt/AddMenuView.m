//
//  AddMenuView.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "AddMenuView.h"
#import "MyComboBox.h"
#import "ServerHelper.h"
#import <PromiseKit/PromiseKit.h>

@implementation AddMenuView

- (void)awakeFromNib {
	[super awakeFromNib];
	
	self.routeDropdown.delegate = self;
	self.stopDropBox.delegate = self;
	
	[ServerHelper getAllRoutes].then(^(NSArray *routes) {
		NSLog(@"got routes: %@", routes);
		
		for (NSString *name in routes) {
			[self.routeDropdown addItemWithObjectValue:name];
		}
	});
}

- (void)comboBoxSelectionDidChange:(NSNotification *)notification {
	MyComboBox *dropdown = [notification object];
	
	if ([dropdown isEqualTo:self.routeDropdown]) {
		[self updateStopDopdown];
	}
	else if ([dropdown isEqualTo:self.stopDropBox]) {
		
	}
}

- (void)updateStopDopdown {
	
	[self.stopDropBox removeAllItems];
}

@end
