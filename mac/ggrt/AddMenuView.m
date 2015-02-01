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

@implementation AddMenuView {
	NSArray *_routes;
	
	/* Array of Dictionary (all string values):
		- stopId
		- Name
		- Direction
	 */
	NSArray *_stops;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	
	self.routeDropdown.delegate = self;
	self.stopDropBox.delegate = self;
	
	[ServerHelper getAllRoutes].then(^(NSArray *routes) {
		_routes = routes;
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

- (IBAction)addButtonPressed:(NSButton *)sender {
	NSString *routeId = [_routes objectAtIndex:self.routeDropdown.indexOfSelectedItem];
	NSString *stopId = [[_stops objectAtIndex:self.stopDropBox.indexOfSelectedItem] objectForKey:@"stopId"];
	
	stopId = @"1234";
	
	NSDictionary *dict = @{
		@"routeId": routeId,
		@"stopId":	stopId
	};
	[[NSNotificationCenter defaultCenter] postNotificationName:kReallyDidAddNewBusNotification object:dict];
}

@end
