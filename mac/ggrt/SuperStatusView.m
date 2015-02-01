//
//  SuperStatusView.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "SuperStatusView.h"

@implementation SuperStatusView

- (void)determineStatusBarColour {
	// http://stackoverflow.com/a/24659148
	_isDarkStatusBar = [[[NSAppearance currentAppearance] name] rangeOfString:@"NSAppearanceNameVibrantDark"].length > 0;
}

- (void)awakeFromNib {
	self.autoresizingMask = NSViewWidthSizable;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(style) name:kTheMenuWillOpenNotification object:nil];
	
	[self style];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Stylin

- (void)style {
	[self determineStatusBarColour];
	
	self.separatorView.wantsLayer = YES;
	self.separatorView.layer.backgroundColor = [self separatorColor];
}

- (CGColorRef)separatorColor {
	if (_isDarkStatusBar) {
		return [MONO(0.6) CGColor];
	}
	
	return [MONO(0.7) CGColor];
}

- (NSColor *)defaultTextColor {
	if (_isDarkStatusBar) {
		return MONO(1);
	}
	
	return MONO(0);
}

- (NSColor *)descriptionTextColor {
	if (_isDarkStatusBar) {
		return MONO(0.95);
	}
	
	return MONO(0.05);
}

@end
