//
//  DefaultIconView.m
//  ggrt
//
//  Created by Jerry Yu on 2015-02-01.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "DefaultIconView.h"

@implementation DefaultIconView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
	
	// http://stackoverflow.com/questions/354610/create-a-colored-bubble-circle-programmatically-in-objectivec-and-cocoa
	// Get the graphics context that we are currently executing under
	NSGraphicsContext* gc = [NSGraphicsContext currentContext];
	
	// Save the current graphics context settings
	[gc saveGraphicsState];
	
	// Set the color in the current graphics context for future draw operations
	[[NSColor clearColor] setStroke];
	if (self.isDefault) {
		[COLOUR(0, 186, 255) setFill];
	}
	else if (self.hover){
		[COLOUR(0, 186, 255) setStroke];
		[[NSColor clearColor] setFill];
	}
	else {
		[[NSColor clearColor] setFill];
	}
	
	// Create our circle path
	NSRect rect = NSMakeRect(0, 0, 6, 6);
	NSBezierPath* circlePath = [NSBezierPath bezierPath];
	[circlePath appendBezierPathWithOvalInRect: rect];
	[circlePath stroke];
	[circlePath fill];
	
	// Restore the context to what it was before we messed with it
	[gc restoreGraphicsState];
}

@end
