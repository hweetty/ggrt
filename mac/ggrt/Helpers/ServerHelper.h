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

+ (PMKPromise *)getLatestVersionNumber:(NSString *)currentVersion;

+ (PMKPromise *)getInfoForRoute:(NSString *)routeId stop:(NSString *)stopId;

@end
