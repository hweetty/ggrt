//
//  BusStatusView.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GGSuperMenuView.h"

@class BusStatusItem;
@class DefaultIconView;

@interface BusStatusView : GGSuperMenuView

@property (nonatomic) int minutesRemaining;

@property (nonatomic, weak) BusStatusItem *delegate;
@property (nonatomic) BOOL isDefault;

@property (weak) IBOutlet DefaultIconView *defaultIconView;
@property (weak) IBOutlet NSTextField *routeLabel;
@property (weak) IBOutlet NSTextField *destinationLabel;
@property (weak) IBOutlet NSTextField *originLabel;

@property (weak) IBOutlet NSTextField *timeRemainingLabel;
@property (weak) IBOutlet NSTextField *secondTimeRemainingLabel;

// Set the info for this bus route
- (void)setDictionary:(NSDictionary *)dict;

@end
