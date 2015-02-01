//
//  MyComboBox.m
//  ggrt
//
//  Created by Jerry Yu on 2015-02-01.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "MyComboBox.h"

@implementation MyComboBox

- (void)mouseDown:(NSEvent *)theEvent {
	NSLog(@"down");
	[(NSComboBoxCell*)self.cell performSelector:@selector(popUp:)];
}

@end
