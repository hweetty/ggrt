//
//  SettingsStatusView.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SettingsStatusView : NSView {
	
}

@property (weak) IBOutlet NSTextField *creditsLabel;

- (IBAction)addButtonPressed:(NSButton *)sender;
- (IBAction)quitButtonPressed:(NSButton *)sender;
@end
