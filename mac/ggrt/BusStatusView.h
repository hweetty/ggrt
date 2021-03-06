//
//  BusStatusView.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SuperStatusView.h"

@class BusStatusItem;
@class DefaultIconView;

@interface BusStatusView : SuperStatusView

@property (nonatomic) int minutesRemaining;

@property (nonatomic, weak) BusStatusItem *delegate;
@property (nonatomic) BOOL isDefault;

// Do not touch below
@property (weak) IBOutlet DefaultIconView *defaultIconView;
@property (weak) IBOutlet NSTextField *routeLabel;
@property (weak) IBOutlet NSTextField *descriptionLabel;
@property (weak) IBOutlet NSTextField *timeRemainingLabel;
@property (weak) IBOutlet NSButton *deleteButton;

- (IBAction)deleteButtonPressed:(NSButton *)sender;

@end
