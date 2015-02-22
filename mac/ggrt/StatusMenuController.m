//
//  StatusMenuController.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "StatusMenuController.h"
#import "GGSuperMenu.h"
#import "BusStatusView.h"
#import "SettingsStatusView.h"
#import "PollPushManager.h"

#define kBusRoutesKey @"kBusRoutesKey"
#define kDefaultRouteIndexKey @"kDefaultRouteIndexKey"

@implementation StatusMenuController

@synthesize theMenu;
@synthesize statusItem;

- (instancetype)initWithMenu:(NSMenu *)menu item:(NSStatusItem *)item {
	if ((self = [super init])) {
		self.theMenu = menu;
		self.statusItem = item;
		statusItem.highlightMode = YES;
		[statusItem setImage:[NSImage imageNamed:@"bus"]];
		[statusItem setAlternateImage:[NSImage imageNamed:@"bus"]];
		
		[self loadRoutes];
		[PollPushManager updateNow];
		
		GGSuperMenu *item = [[GGSuperMenu alloc] initWithNibViewClass:[SettingsStatusView class]];
		[self.theMenu addItem:item];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quitAppButtonPressed) name:kQuitAppNotification object:nil];

		_minutes = -1;
	}
	
	return self;
}

static BOOL _route = NO;

- (void)swapTitle {
	[self performSelector:@selector(swapTitle) withObject:nil afterDelay:2];
	
	_route = !_route;
	[self updateSwappingTitle];
}
- (void)updateSwappingTitle {
	if (_defaultIndex == -1) {
//		[self setDefaultStatusTitle];
	}
	else {
		if (_route) {
			[self.statusItem setTitle:[[_busRoutes objectAtIndex:_defaultIndex] objectForKey:@"routeId"]];
		}
		else {
			if (_minutes == -1) {
				[self.statusItem setTitle:@"?m"];
			}
			else {
				[self.statusItem setTitle:[NSString stringWithFormat:@"%dm", _minutes]];
			}
		}
	}
}

- (void)loadRoutes {
	NSArray *savedRoutes = [[NSUserDefaults standardUserDefaults] objectForKey:kBusRoutesKey];
	if (savedRoutes) {
		_busRoutes = [[NSMutableArray alloc] initWithArray:savedRoutes];
	}
	else {
		_busRoutes  = [[NSMutableArray alloc] init];
	}
	
	while (_busRoutes.count > 1) {
		[_busRoutes removeLastObject];
	}
	
	[self.theMenu removeAllItems];
	for (NSDictionary *dict in _busRoutes) {
		GGSuperMenu *item = [[GGSuperMenu alloc] initWithNibViewClass:[BusStatusView class]];
		[(BusStatusView *)item.view setDictionary:dict];
		[self.theMenu addItem:item];
	}
}

- (void)save {
	[[NSUserDefaults standardUserDefaults] setObject:_busRoutes forKey:kBusRoutesKey];
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_defaultIndex] forKey:kDefaultRouteIndexKey];
}


#pragma mark - Notifications

- (void)quitAppButtonPressed {
	[[NSApplication sharedApplication] terminate:self];
}

@end
