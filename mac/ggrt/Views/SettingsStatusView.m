//
//  SettingsStatusView.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "SettingsStatusView.h"

@implementation SettingsStatusView

static BOOL _isDarkStatusBar = NO;

+ (void)determineStatusBarColour {
	// http://stackoverflow.com/a/24659148
	_isDarkStatusBar = [[[NSAppearance currentAppearance] name] rangeOfString:@"NSAppearanceNameVibrantDark"].length > 0;
}

- (void)awakeFromNib {
	self.autoresizingMask = NSViewWidthSizable;
	
	self.creditsLabel.stringValue = [@"GGrt " stringByAppendingFormat:@"v%@", kGGRTAppVersionNumber];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(style) name:kTheMenuWillOpenNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newVersionAvailable:) name:kNewVersionAvailableNotification object:nil];
	[self style];
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)newVersionAvailable:(NSNotification *)aNotif {
	NSDictionary *dict = [aNotif object];
	NSURL *url = [NSURL URLWithString:dict[@"url"]];
}

- (IBAction)addButtonPressed:(NSButton *)sender {
	[[NSNotificationCenter defaultCenter] postNotificationName:kAddButtonPressedNotification object:nil];
}

- (IBAction)quitButtonPressed:
	(NSButton *)sender {
		[[NSNotificationCenter defaultCenter] postNotificationName:kQuitAppNotification object:nil];
}


#pragma mark - Styles

- (void)style {
	[SettingsStatusView determineStatusBarColour];
	self.creditsLabel.textColor = [self creditsTextcolour];
}

- (NSColor *)creditsTextcolour {
	if (_isDarkStatusBar) {
		return MONO(0.8);
	}
	
	return MONO(0.5);
}

@end
