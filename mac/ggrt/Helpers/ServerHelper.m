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

+ (PMKPromise *)getLatestVersionNumber:(NSString *)currentVersion {
	NSString *path = [kBaseURLPath stringByAppendingFormat:@"latestVersion?currentVersion=%@", currentVersion];
	NSLog(@"hitting url: %@", path);
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
	
	return [NSURLConnection promise:request];
}

+ (PMKPromise *)getInfoForRoute:(NSString *)routeId stop:(NSString *)stopId {
	NSString *path = [kBaseURLPath stringByAppendingFormat:@"GetStopInfo?routeId=%@&stopId=%@", routeId, stopId];
	NSLog(@"hitting url: %@", path);
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
	
	return [NSURLConnection promise:request];
}

@end
