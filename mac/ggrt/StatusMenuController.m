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

#import "SettingsStatusItem.h"
#import "AddMenuItem.h"
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
		
		_isAdding = NO;
		[self loadRoutes];
//		[self loadDefault];
		[PollPushManager updateNow];
		
		SettingsStatusItem *settings = [[SettingsStatusItem alloc] init];
		[self.theMenu addItem:settings];
		
		// Notifications
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addButtonPressed) name:kAddButtonPressedNotification object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewCell:) name:kReallyDidAddNewBusNotification object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCell:) name:kDeletedBusNotification object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quitAppButtonPressed) name:kQuitAppNotification object:nil];
		
//		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuClosed) name:kTheMenuDidClosenNotification object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultChanged:) name:kDefaultBusRouteChangedNotification object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(minutesChanged:) name:kUpdateDefaultBusMinutesLeftNotification object:nil];
		
		_minutes = -1;
//		[self swapTitle];
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
		[self setDefaultStatusTitle];
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

- (void)minutesChanged:(NSNotification *)aNotif {
	if (aNotif) {
		_minutes = [[aNotif object] intValue];
	}
	
	_route = YES;
	[self updateSwappingTitle];
}

- (void)setDefaultStatusTitle {
	[self.statusItem setTitle:@"GGRT"];
}

- (void)loadDefault {
	NSAssert (_busRoutes, @"must load routes first");
	_defaultIndex = [[[NSUserDefaults standardUserDefaults] objectForKey:kDefaultRouteIndexKey] intValue];
	
	if (_busRoutes.count == 0) {
		_defaultIndex = -1;
		[self setDefaultStatusTitle];
	}
	
	if (_defaultIndex >= 0) {
//		BusStatusItem *item = (BusStatusItem *)[self.theMenu itemAtIndex:_defaultIndex];
//		[(BusStatusView *)item.view setIsDefault:YES];
	}
	
	[self minutesChanged:nil];
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
//		BusStatusItem *item = [[BusStatusItem alloc] initWithDictionary:dict];
//		BusStatusView
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

- (void)defaultChanged:(NSNotification *)aNotif {
	// Set previous
//	if (_defaultIndex >= 0 && _defaultIndex < _busRoutes.count) {
//		BusStatusItem *item = (BusStatusItem *)[self.theMenu itemAtIndex:_defaultIndex];
//		[(BusStatusView *)item.view setIsDefault:NO];
//	}
//	
//	BusStatusItem *item = [aNotif object];
//	if (item) {
//		[(BusStatusView *)item.view setIsDefault:YES];
//		_defaultIndex = [self.theMenu indexOfItem:item];
//	}
//	else {
//		_defaultIndex = -1;
//		[self setDefaultStatusTitle];
//	}

	[self minutesChanged:nil];
	[self save];
}

- (void)insertItemBelowSettings:(NSMenuItem *)item {
	NSUInteger numItems = self.theMenu.numberOfItems;
	NSAssert(numItems > 0, @"There should be at least the settings view");
	[self.theMenu insertItem:item atIndex:numItems-1];
}

- (void)addButtonPressed {
	if (_isAdding)	return;
	_isAdding = YES;
	
	AddMenuItem *item = [[AddMenuItem alloc] init];
	[self insertItemBelowSettings:item];
}

- (void)addNewCell:(NSNotification *)aNotification {
	if (_isAdding == NO)	return;
	[self menuClosed]; // Remove the AddMenuItem
	
	// Insert new item
	NSDictionary *dict = [aNotification object];
	[_busRoutes addObject:dict];
	[self save];
	
//	BusStatusItem *item = [[BusStatusItem alloc] initWithDictionary:dict];
//	[self insertItemBelowSettings:item];
}

- (void)deleteCell:(NSNotification *)aNotification {
	NSAssert(self.theMenu.numberOfItems > 1, @"There should be at least one bus cell");
	
	BusStatusItem *item = [aNotification object];
	NSUInteger i = [self.theMenu indexOfItem:item];
	NSAssert(i >= 0 && i < _busRoutes.count, @"Invalid range of item");
	
	// Update default index?
	if (_defaultIndex < i) {
		_defaultIndex--;
	}
	else if (_defaultIndex == 0) {
		_defaultIndex = -1;
	}
	
	[_busRoutes removeObjectAtIndex:i];
	[self.theMenu removeItemAtIndex:i];
	[self save];
}

- (void)quitAppButtonPressed {
	[[NSApplication sharedApplication] terminate:self];
}

- (void)menuClosed {
	if (_isAdding == NO)	return;
	_isAdding = NO;
	
	NSUInteger numItems = self.theMenu.numberOfItems;
	NSAssert(numItems >= 2, @"Should be at least two items");
	[self.theMenu removeItemAtIndex:numItems - 2];
}


@end
