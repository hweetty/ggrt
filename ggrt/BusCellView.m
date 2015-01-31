//
//  BusCellView.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "BusCellView.h"

@implementation BusCellView


- (void)awakeFromNib {
	self.separatorView.wantsLayer = YES;
	self.separatorView.layer.backgroundColor = CGColorCreateGenericGray(0.5, 1);
}

@end
