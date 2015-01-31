//
//  BusStatusItem.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BusStatusView;

@interface BusStatusItem : NSMenuItem {
	BusStatusView *_view;
}

@property (nonatomic, readonly) NSString *routeId;
@property (nonatomic, readonly) NSString *stopId;
@property (nonatomic, strong) NSDictionary *busData;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
