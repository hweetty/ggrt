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
	
	NSString *routeId = [_routes objectAtIndex:self.routeDropdown.indexOfSelectedItem];
	[ServerHelper getStopsForRoute:routeId]
	.then(^(NSArray *stops) {
		_stops = stops;
		for (NSDictionary *dict in stops) {
			NSString *name = [NSString stringWithFormat:@"%@ %@", dict[@"StopId"], dict[@"Name"]];
			[self.stopDropBox addItemWithObjectValue:name];
		}
	});
}

- (IBAction)addButtonPressed:(NSButton *)sender {
	NSString *routeId = [_routes objectAtIndex:self.routeDropdown.indexOfSelectedItem];
	NSString *stopId = [[_stops objectAtIndex:self.stopDropBox.indexOfSelectedItem] objectForKey:@"StopId"]; // Caps
	NSString *desc = [[_stops objectAtIndex:self.stopDropBox.indexOfSelectedItem] objectForKey:@"Name"]; // Caps
	
	NSDictionary *dict = @{
		@"routeId": routeId,
		@"stopId":	stopId,
		@"desc": desc
	};
	[[NSNotificationCenter defaultCenter] postNotificationName:kReallyDidAddNewBusNotification object:dict];
}

@end
