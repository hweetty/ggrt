//
//  BusStatusView.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "BusStatusView.h"

@implementation BusStatusView

- (void)setMinutesRemaining:(int)mins {
	_minutesRemaining = mins;
	
	NSString *str = [NSString stringWithFormat:@"%d min%@", mins, (mins!=1?@"s":@"")];
	
	NSRange range = [str rangeOfString:@" min"];
	if (mins != 1) {
		range.length++;
	}
	
	NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:str];
	[as addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:10] range:range];
	[as addAttribute:NSForegroundColorAttributeName value:[self defaultTextColor] range:range];
	
	self.timeRemainingLabel.textColor = [self timeRemainingTextColour];
	self.timeRemainingLabel.attributedStringValue = as;
}


#pragma mark - Override

- (void)style {
	[super style];
	
	// Style the MinutesRemaining label
	self.minutesRemaining = _minutesRemaining;
	
	self.descriptionLabel.textColor = [self descriptionTextColor];
}

- (NSColor *)timeRemainingTextColour {
	if (self.isDarkStatusBar) {
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


@end
