//
//  AddMenuView.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SuperStatusView.h"

@interface AddMenuView : SuperStatusView<NSTextFieldDelegate>

@property (weak) IBOutlet NSTextField *routeTextfield;

@end
