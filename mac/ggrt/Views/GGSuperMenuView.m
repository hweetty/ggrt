//
//  GGSuperMenuView.m
//  ggrt
//
//  Created by Jerry Yu on 2015-02-22.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "GGSuperMenuView.h"

@implementation GGSuperMenuView

- (void)awakeFromNib {
	[super awakeFromNib];
	[self determineStatusBarColour];
}

- (void)determineStatusBarColour {
	// http://stackoverflow.com/a/24659148

	NSAppearance *app = [NSAppearance currentAppearance];
	if ([app respondsToSelector:@selector(name)] &&
		[[app name] rangeOfString:@"NSAppearanceNameVibrantDark"].length > 0) {
		_isDarkAppearance = YES;
	}
	else {
		_isDarkAppearance = NO;
	}
}

- (CGColorRef)separatorColor {
	if (_isDarkAppearance) {
		return [MONO(0.6) CGColor];
	}

	return [MONO(0.7) CGColor];
}

- (NSColor *)defaultTextColor {
	if (_isDarkAppearance) {
		return MONO(1);
	}

	return MONO(0);
}

- (NSColor *)descriptionTextColor {
	if (_isDarkAppearance) {
		return MONO(0.95);
	}

	return MONO(0.05);
}

@end
