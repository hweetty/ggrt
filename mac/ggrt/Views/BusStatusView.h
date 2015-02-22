//
//  BusStatusView.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GGSuperMenuView.h"

@interface BusStatusView : GGSuperMenuView

@property (weak) IBOutlet NSTextField *routeLabel;
@property (weak) IBOutlet NSTextField *destinationLabel;
@property (weak) IBOutlet NSTextField *originLabel;

@property (weak) IBOutlet NSTextField *timeRemainingLabel;
@property (weak) IBOutlet NSTextField *secondTimeRemainingLabel;

// Set the info for this bus route
// routeId
// destinationString
// originString
// timeRemaing
// secondTimeRemaining
- (void)setDictionary:(NSDictionary *)dict;

// Use for only updating the times
- (void)setMinutesRemaining:(int)mins secondary:(int)smins;

@end
