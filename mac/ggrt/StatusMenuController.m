//
//  StatusMenuController.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "StatusMenuController.h"
#import "BusStatusItem.h"
#import "SettingsStatusItem.h"
#import "AddMenuItem.h"
#import "PollPushManager.h"

#define kBusRoutesKey @"kBusRoutesKey"

@implementation StatusMenuController

@synthesize theMenu;
@synthesize statusItem;

- (instancetype)initWithMenu:(NSMenu *)menu item:(NSStatusItem *)item {
	if ((self = [super init])) {
		self.theMenu = menu;
		self.statusItem = item;
		
		[item setTitle:@"10m\n200"];
		
		NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:@"200\n10 mins"];
		NSRange range = NSMakeRange(0, as.length);
		[as addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:10] range:range];
		
		statusItem.attributedTitle = as;
		[statusItem setHighlightMode:YES];
		
		_isAdding = NO;
		[self loadDefaults];
		[PollPushManager updateNow];
		
		SettingsStatusItem *settings = [[SettingsStatusItem alloc] init];
		[self.theMenu addItem:settings];
		
		// Notifications
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addButtonPressed) name:kAddButtonPressedNotification object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addNewCell:) name:kReallyDidAddNewBusNotification object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteCell:) name:kDeletedBusNotification object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quitAppButtonPressed) name:kQuitAppNotification object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuClosed) name:kTheMenuDidClosenNotification object:nil];
	}
	
	return self;
}

- (void)loadDefaults {
	NSArray *savedRoutes = [[NSUserDefaults standardUserDefaults] objectForKey:kBusRoutesKey];
	if (savedRoutes) {
		_busRoutes = [[NSMutableArray alloc] initWithArray:savedRoutes];
	}
	else {
		_busRoutes  = [[NSMutableArray alloc] init];
	}
	
	[self.theMenu removeAllItems];
	for (NSDictionary *dict in _busRoutes) {
		BusStatusItem *item = [[BusStatusItem alloc] initWithDictionary:dict];
		[self.theMenu addItem:item];
	}
}

- (void)save {
	[[NSUserDefaults standardUserDefaults] setObject:_busRoutes forKey:kBusRoutesKey];
}


#pragma mark - Notifications

- (void)insertItemBelowSettings:(NSMenuItem *)item {
	NSUInteger numItems = self.theMenu.numberOfItems;
	NSAssert(numItems > 0, @"There should be at least the settings view");
	[self.theMenu insertItem:item atIndex:numItems-1];
}

- (void)addButtonPressed {
	if (_isAdding)	return;
	_isAdding = YES;
	
	NSLog(@"creating new ");
	AddMenuItem *item = [[AddMenuItem alloc] init];
	[self insertItemBelowSettings:item];
}

- (void)addNewCell:(NSNotification *)aNotification {
	if (_isAdding == NO)	return;
	[self menuClosed]; // Remove the AddMenuItem
	
	// Insert new item
	NSDictionary *dict = [aNotification object];
	NSLog(@"got: %@", dict);
	[_busRoutes addObject:dict];
	[self save];
	
	BusStatusItem *item = [[BusStatusItem alloc] initWithDictionary:dict];
	
	[self insertItemBelowSettings:item];
}

- (void)deleteCell:(NSNotification *)aNotification {
	NSAssert(self.theMenu.numberOfItems > 1, @"There should be at least one bus cell");
	
	BusStatusItem *item = [aNotification object];
	NSUInteger i = [self.theMenu indexOfItem:item];

	NSAssert(i >= 0 && i < _busRoutes.count, @"Invalid range of item");
	[_busRoutes removeObjectAtIndex:i];
	[self.theMenu removeItemAtIndex:i];
	[self save];
}

- (void)quitAppButtonPressed {
	NSLog(@"quiting ");
	[self save];
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
