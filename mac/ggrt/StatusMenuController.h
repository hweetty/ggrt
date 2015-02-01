//
//  StatusMenuController.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StatusMenuController : NSObject {
	/* Array of dictionaries:
		routeId: 200,
		stopId: 3629
	 */
	NSMutableArray *_busRoutes;
	BOOL _isAdding;
	NSInteger _defaultIndex; // -1 for none
	int _minutes;
}

@property (nonatomic, weak) NSMenu *theMenu;
@property (nonatomic, weak) NSStatusItem *statusItem;

- (instancetype)initWithMenu:(NSMenu *)menu item:(NSStatusItem *)item;

@end
