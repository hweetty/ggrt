//
//  GGSuperMenu.m
//  ggrt
//
//  Created by Jerry Yu on 2015-02-15.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "GGSuperMenu.h"
#import "NSNib+Additions.h"
#import "GGSuperMenuView.h"

@implementation GGSuperMenu

- (instancetype)initWithNibViewClass:(Class)class {
	if ((self = [super init])) {
		self.view = [NSNib loadNibWithClass:class];
	}
	
	return self;
}

@end
