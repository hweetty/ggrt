//
//  SuperStatusView.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SuperStatusView : NSView

@property (nonatomic, readonly) BOOL isDarkStatusBar;
@property (weak) IBOutlet NSView *separatorView;

- (void)style;

- (NSColor *)defaultTextColor;
- (NSColor *)descriptionTextColor;
		
@end
