//
//  ServerHelper.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "ServerHelper.h"
#import <PromiseKit/PromiseKit.h>

#define kAllRoutesKey @"kAllRoutesKey"

@implementation ServerHelper

static NSCache *_cache = nil;

+ (NSCache *)cache {
	if (!_cache) {
		_cache = [[NSCache alloc] init];
		[self prepopulateCache];
	}
	
	return _cache;
}

+ (PMKPromise *)prepopulateCache {
	return nil;
}


#pragma mark - GRT Info

+ (PMKPromise *)getInfoForRoute:(NSString *)routeId stop:(NSString *)stopId {
	NSString *path = [kBaseURLPath stringByAppendingFormat:@"GetStopInfo?routeId=%@&stopId=%@", routeId, stopId];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
	
	return [NSURLConnection promise:request];
}

+ (PMKPromise *)getAllRoutes {
	NSCache *cache = [self cache];
	NSArray *routes = [cache objectForKey:kAllRoutesKey];
	
	if (routes && [routes count] > 0) {
		return [PMKPromise promiseWithValue:routes];
	}
	
	NSString *path = [kBaseURLPath stringByAppendingFormat:@"getAllRoutes"];
	NSLog(@"hitting url: %@", path);
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
	
	return [NSURLConnection promise:request]
	.then(^NSArray*(NSDictionary *dict) {
		if ([dict isKindOfClass:[NSDictionary class]] && [dict[@"status"] intValue] == 200) {
			NSArray *arr = [dict objectForKey:@"routes"];
			if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
				[cache setObject:arr forKey:kAllRoutesKey];
				return arr;
			}
		}
		
		@throw @"error";
	})
	.catch(^NSArray *(id error) {
		NSLog(@"error: %@", error);
		return @[@"Error retrieving all routes"];
	});
}

+ (PMKPromise *)getDescriptionForRouteId:(NSString *)routeId {
	return nil;
}

+ (PMKPromise *)getStopsForRoute:(NSString *)routeId {
	NSCache *cache = [self cache];
	NSString *key = [routeId stringByAppendingString:@" stops"];
	NSArray *stops = [cache objectForKey:key];
	
	if (stops && [stops count] > 0) {
		return [PMKPromise promiseWithValue:stops];
	}
	
	NSString *path = [kBaseURLPath stringByAppendingFormat:@"GetStopsForRoute?routeId=%@", routeId];
	NSLog(@"hitting url: %@", path);
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
	
	return [NSURLConnection promise:request]
	.then(^NSArray*(NSDictionary *dict) {
		if ([dict isKindOfClass:[NSDictionary class]] && [dict[@"status"] intValue] == 200) {
			NSArray *arr = [dict objectForKey:@"stops"];
			if ([arr isKindOfClass:[NSArray class]] && arr.count > 0) {
				[cache setObject:arr forKey:key];
				return arr;
			}
		}
		
		@throw @"error";
	})
	.catch(^NSArray *(id error) {
		NSLog(@"error: %@", error);
		return @[@"Error retrieving all routes"];
	});
}


#pragma mark - Other

+ (PMKPromise *)getLatestVersionNumber:(NSString *)currentVersion {
	NSString *path = [kBaseURLPath stringByAppendingFormat:@"latestVersion?currentVersion=%@", currentVersion];
	NSLog(@"hitting url: %@", path);
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:path]];
	
	return [NSURLConnection promise:request];
}

@end
