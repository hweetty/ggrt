//
//  GRTInfoHelper.m
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import "GRTInfoHelper.h"
#import <PromiseKit/PromiseKit.h>

@implementation GRTInfoHelper

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


#pragma mark -

+ (PMKPromise *)getDescriptionForRouteId:(NSString *)routeId {
	return nil;
}

@end
