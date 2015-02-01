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
	[(NSComboBoxCell*)self.cell performSelector:@selector(popUp:)];
}

// Silence annoying warning
- (void)popUp:(id)hi {
	NSLog(@"shouldnt happen");
}

@end
