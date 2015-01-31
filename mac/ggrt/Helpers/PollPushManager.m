//
//  PollPushManager.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "PollPushManager.h"

@implementation PollPushManager

static BOOL _started = NO;
static BOOL _isPolling = YES;

+ (void)start {
	if (_started)	return;
	_started = YES;
	
	_isPolling = YES;
	[self beginPolling];
}

+ (void)updateNow {
	[self postNotification];
}

+ (void)setDeviceToken:(NSData *)deviceToken {
	
}


#pragma mark - Private

+ (void)beginPolling {
	if (_isPolling == NO)	return;
	
	// http://stackoverflow.com/questions/4139219/how-do-you-trigger-a-block-after-a-delay-like-performselectorwithobjectafter
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		[self postNotification];
		[self beginPolling];
	});
}

+ (void)postNotification {
	[[NSNotificationCenter defaultCenter] postNotificationName:kGGRTUpdateNotification object:nil];
}

@end
