//
//  StatusMenuController.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "StatusMenuController.h"
#import "BusStatusItem.h"
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
		
		[self loadDefaults];
		[PollPushManager updateNow];
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

@end
