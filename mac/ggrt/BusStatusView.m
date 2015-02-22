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

- (void)mouseUp:(NSEvent *)theEvent {
	NSLog(@"up");
	if (self.isDefault) {
		[[NSNotificationCenter defaultCenter] postNotificationName:kDefaultBusRouteChangedNotification object:nil];
	}
	else {
		[[NSNotificationCenter defaultCenter] postNotificationName:kDefaultBusRouteChangedNotification object:self.delegate];
	}
}


#pragma mark - UI Interactions

- (void)mouseEntered:(NSEvent *)theEvent {
	self.defaultIconView.hover = YES;
	[self.defaultIconView setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)theEvent {	
	self.defaultIconView.hover = NO;
	[self.defaultIconView setNeedsDisplay:YES];
}

- (void)setIsDefault:(BOOL)isDefault {
	_isDefault = isDefault;
	self.defaultIconView.isDefault = isDefault;
	[self.defaultIconView setNeedsDisplay:YES];
	[self updateController];
}

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
	
	[self updateController];
}

- (void)updateController {
	if (self.isDefault) {
		[[NSNotificationCenter defaultCenter] postNotificationName:kUpdateDefaultBusMinutesLeftNotification object:[NSNumber numberWithInt:self.minutesRemaining]];
	}
}

- (void)mouseDown:(NSEvent *)theEvent {
	NSLog(@"mouse down");
}


#pragma mark - Override

- (void)style {
	[super style];
	
	// Style the MinutesRemaining label
	self.minutesRemaining = _minutesRemaining;
	
//	self.descriptionLabel.textColor = [self descriptionTextColor];
}

- (NSColor *)timeRemainingTextColour {
	if (self.isDarkAppearance) {
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

- (IBAction)deleteButtonPressed:(NSButton *)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kDeletedBusNotification object:self.delegate];
}

@end
