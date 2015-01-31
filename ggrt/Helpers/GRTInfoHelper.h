//
//  GRTInfoHelper.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PMKPromise;

@interface GRTInfoHelper : NSObject

+ (PMKPromise *)getDescriptionForRouteId:(NSString *)routeId;

@end
