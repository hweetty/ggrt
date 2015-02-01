//
//  BusStatusView.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SuperStatusView.h"

@interface BusStatusView : SuperStatusView

@property (nonatomic) int minutesRemaining;

// Do not touch below
@property (weak) IBOutlet NSTextField *routeLabel;
@property (weak) IBOutlet NSTextField *descriptionLabel;
@property (weak) IBOutlet NSTextField *timeRemainingLabel;

@end
