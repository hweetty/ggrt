//
//  GGSuperMenuView.h
//  ggrt
//
//  Created by Jerry Yu on 2015-02-22.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GGSuperMenuView : NSView

@property (nonatomic, readonly) BOOL isDarkAppearance;

@property (weak) IBOutlet NSView *separatorView;

// Subclasses should use isDarkAppearance to use dark/light appearance.
// This will only be called if it changed, and on init
// Must call super
- (void)style;

- (NSColor *)defaultTextColor;
- (NSColor *)descriptionTextColor;


@end
