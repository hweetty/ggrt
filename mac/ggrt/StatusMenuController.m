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

static NSString *const kBusRoutesKey = @"kBusRoutesKey";

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
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addButtonPressed) name:kAddNewBusNotification object:nil];

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
	
	NSDictionary *d = @{
		@"routeId": @"200",
		@"stopId": @"3629"
	};
	[_busRoutes addObject:d];
	
	NSDictionary *dd = @{
		@"routeId": @"9",
		@"stopId": @"1123"
	};
	[_busRoutes addObject:dd];
	
	[self.theMenu removeAllItems];
	for (NSDictionary *dict in _busRoutes) {
		BusStatusItem *item = [[BusStatusItem alloc] initWithDictionary:dict];
		[self.theMenu addItem:item];
	}
}

- (void)save {
	NSLog(@"saving");
}


#pragma mark - Notifications

- (void)addButtonPressed {
	if (_isAdding)	return;
	_isAdding = YES;
	
	NSLog(@"creating new ");
	AddMenuItem *item = [[AddMenuItem alloc] init];
	NSUInteger numItems = self.theMenu.numberOfItems;
	NSAssert(numItems > 0, @"There should be at least the settings view");
	[self.theMenu insertItem:item atIndex:numItems-1];
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
