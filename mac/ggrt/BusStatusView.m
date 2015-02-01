//
//  BusStatusView.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "BusStatusView.h"

#define MONO(amt) [NSColor colorWithDeviceWhite:amt alpha:1]

#define MONO_ALPHA(amt, alp) [NSColor colorWithDeviceWhite:amt alpha:alp]

#define COLOUR(r, g, b) [NSColor colorWithDeviceRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]


@implementation BusStatusView

static BOOL _isDarkStatusBar = NO;

+ (void)determineStatusBarColour {
	// http://stackoverflow.com/a/24659148
	_isDarkStatusBar = [[[NSAppearance currentAppearance] name] rangeOfString:@"NSAppearanceNameVibrantDark"].length > 0;
}

- (void)awakeFromNib {
	[self style];
}

- (void)setMinutesRemaining:(int)mins {
	_minutesRemaining = mins;
	
	NSString *str = [NSString stringWithFormat:@"%d min%@", mins, (mins>0?@"s":@"")];
	
	NSRange range = [str rangeOfString:@" min"];
	if (mins > 0) {
		range.length++;
	}
	
	NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:str];
	[as addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:10] range:range];
	[as addAttribute:NSForegroundColorAttributeName value:[self defaultTextColor] range:range];
	
	self.timeRemainingLabel.textColor = [self timeRemainingTextColour];
	self.timeRemainingLabel.attributedStringValue = as;
}


#pragma mark - Stylin

- (void)style {
	[BusStatusView determineStatusBarColour];
	
	self.descriptionLabel.textColor = [self descriptionTextColor];
	
	self.separatorView.wantsLayer = YES;
	self.separatorView.layer.backgroundColor = [self separatorColor];
}

- (CGColorRef)separatorColor {
	if (_isDarkStatusBar) {
		return [MONO(0.6) CGColor];
	}
	
	return [MONO(0.4) CGColor];
}

- (NSColor *)timeRemainingTextColour {
	if (_isDarkStatusBar) {
		if (_minutesRemaining > 10) {
			return COLOUR(0, 255, 0);
		}
		else if (_minutesRemaining > 5) {
			return COLOUR(255, 176, 22);
		}
		else {
			return COLOUR(255, 64, 64);
		}
	}
	else {
		if (_minutesRemaining > 10) {
			return COLOUR(0, 175, 0);
		}
		else if (_minutesRemaining > 5) {
			return COLOUR(245, 100, 0);
		}
		else {
			return COLOUR(255, 32, 0);
		}
	}
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
