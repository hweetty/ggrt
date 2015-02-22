//
//  NSNib+Additions.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "NSNib+Additions.h"

@implementation NSNib (Additions)

+ (id)loadNibWithClass:(Class)class {
	NSArray *topLevelObjects;
	NSNib *nib = [[NSNib alloc] initWithNibNamed:NSStringFromClass(class) bundle:[NSBundle mainBundle]];
	[nib instantiateWithOwner:nil topLevelObjects:&topLevelObjects];
	for (id obj in topLevelObjects) {
		if ([obj isKindOfClass:[NSView class]]) {
			return obj;
		}
	}
	
	return nil;
}

@end
