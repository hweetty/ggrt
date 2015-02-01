//
//  ServerHelper.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PMKPromise;

@interface ServerHelper : NSObject

+ (PMKPromise *)getInfoForRoute:(NSString *)routeId stop:(NSString *)stopId;

+ (PMKPromise *)getAllRoutes;

+ (PMKPromise *)getDescriptionForRouteId:(NSString *)routeId;

+ (PMKPromise *)getStopsForRoute:(NSString *)routeId;

+ (PMKPromise *)getLatestVersionNumber:(NSString *)currentVersion;

@end
