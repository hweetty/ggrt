//
//  AddMenuView.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SuperStatusView.h"

@class MyComboBox;

@interface AddMenuView : SuperStatusView<NSComboBoxDelegate>

@property (weak) IBOutlet MyComboBox *routeDropdown;
@property (weak) IBOutlet MyComboBox *stopDropBox;


@end
