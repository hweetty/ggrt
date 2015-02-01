//
//  AddMenuItem.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "AddMenuItem.h"
#import "AddMenuView.h"
#import "NSNib+Additions.h"

@implementation AddMenuItem

- (instancetype)init {
	if ((self = [super init])) {
		_view = [NSNib loadNibWithClass:[AddMenuView class]];
		self.view = _view;
	}
	
	return self;
}

@end
