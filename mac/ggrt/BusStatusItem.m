//
//  BusStatusItem.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "BusStatusItem.h"
#import "BusStatusView.h"
#import "NSNib+Additions.h"
#import "ServerHelper.h"
#import "PollPushManager.h"
#import <PromiseKit/PromiseKit.h>

@implementation BusStatusItem

- (instancetype)initWithDictionary:(NSDictionary *)dict {
	if ((self = [super init])) {
		_view = [NSNib loadNibWithClass:[BusStatusView class]];
		self.view = _view;
		_view.delegate = self;
		
		self.busData = dict;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update) name:kGGRTUpdateNotification object:nil];
	}
	
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Get/Set

- (NSString *)routeId {
	if (_busData) {
		return _busData[@"routeId"];
	}
	return nil;
}

- (NSString *)stopId {
	if (_busData) {
		return _busData[@"stopId"];
	}
	return nil;
}

- (void)setBusData:(NSDictionary *)busData {
	NSAssert(busData && busData[@"routeId"] && busData[@"stopId"], @"Not enough bus data info");
	_busData = busData;
	_view.routeLabel.stringValue = busData[@"routeId"];
	_view.descriptionLabel.stringValue = busData[@"desc"]? busData[@"desc"]:@"";
}


#pragma mark - Private

- (void)update {
	[ServerHelper getInfoForRoute:self.routeId stop:self.stopId]
	.then(^(NSDictionary *dict) {
		if ([dict isKindOfClass:[NSDictionary class]]) {
			NSLog(@"dict: %@", dict);
			if (dict[@"Minutes"]) {
				_view.minutesRemaining = [dict[@"Minutes"] intValue];
			}
		}
		else {
			NSLog(@"cannot update. error: %@", dict);
		}
	});
}

@end
