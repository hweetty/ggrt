//
//  BusStatusView.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "BusStatusView.h"
#import "DefaultIconView.h"

@implementation BusStatusView {
	NSDictionary *_dict;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	
	NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:self.bounds options:NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited owner:self userInfo:nil];
	[self addTrackingArea:area];
}


#pragma mark - Public methods

- (void)setDictionary:(NSDictionary *)dict {
	_dict = dict;

//	NSDictionary *uiElements = @{
//								 @"routeId": self.routeLabel,
//								 @"stopId
//								 };
//	self.routeLabel.stringValue
}

- (void)setMinutesRemaining:(int)mins secondary:(int)smins {
	NSString *str = [NSString stringWithFormat:@"%d min%@", mins, (mins!=1?@"s":@"")];
	
	NSRange range = [str rangeOfString:@" min"];
	if (mins != 1) {
		range.length++;
	}
	
	NSMutableAttributedString *as = [[NSMutableAttributedString alloc] initWithString:str];
	[as addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:10] range:range];
	[as addAttribute:NSForegroundColorAttributeName value:[self defaultTextColor] range:range];
	
	self.timeRemainingLabel.textColor = [self timeRemainingTextColour:mins];
	self.timeRemainingLabel.attributedStringValue = as;

	// Secondary
	self.secondTimeRemainingLabel.stringValue = [NSString stringWithFormat:@"%d min%@", smins, (smins!=1?@"s":@"")];
}


#pragma mark - UI Interactions

- (void)mouseUp:(NSEvent *)theEvent {
	NSLog(@"up");
}

- (void)mouseDown:(NSEvent *)theEvent {
	NSLog(@"mouse down");
}


#pragma mark - Styles

- (void)style {
	[super style];

//	self.descriptionLabel.textColor = [self descriptionTextColor];
}

- (NSColor *)timeRemainingTextColour:(int)mins {
	if (self.isDarkAppearance) {
		if (mins > 10) {
			return COLOUR(0, 255, 0);
		}
		else if (mins > 5) {
			return COLOUR(255, 176, 22);
		}
		else {
			return COLOUR(255, 64, 64);
		}
	}
	else {
		if (mins > 10) {
			return COLOUR(0, 175, 0);
		}
		else if (mins > 5) {
			return COLOUR(245, 100, 0);
		}
		else {
			return COLOUR(255, 32, 0);
		}
	}
}

@end
