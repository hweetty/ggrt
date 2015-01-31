//
//  ServerHelper.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "ServerHelper.h"
#import <PromiseKit/PromiseKit.h>

@implementation ServerHelper

#ifdef DEBUG
static NSString *const kBaseURLPath = @"http://localhost:1729/v1/";
#else
static NSString *const kBaseURLPath = @"http://   /v1/";
#endif


+ (PMKPromise *)getInfoForRoute:(NSString *)routeId stop:(NSString *)stopId {
	NSString *path = [kBaseURLPath stringByAppendingFormat:@"GetStopInfo?routeId=%@&stopId=%@", routeId, stopId];
	NSLog(@"hitting url: %@", path);
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
	
	return [NSURLConnection promise:request];
}

@end
