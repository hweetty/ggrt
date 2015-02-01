//
//  SettingsStatusItem.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "SettingsStatusItem.h"
#import "SettingsStatusView.h"
#import "NSNib+Additions.h"

@implementation SettingsStatusItem


- (instancetype)init {
	if ((self = [super init])) {
		_view = [NSNib loadNibWithClass:[SettingsStatusView class]];
		self.view = _view;
	}
	
	return self;
}


@end
