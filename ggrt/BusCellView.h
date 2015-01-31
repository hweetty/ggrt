//
//  BusCellView.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BusCellView : NSView

@property (weak) IBOutlet NSTextField *busNumberLabel;
@property (weak) IBOutlet NSTextField *routeLabel;
@property (weak) IBOutlet NSTextField *timeRemainingLabel;

@property (weak) IBOutlet NSView *separatorView;

@end
