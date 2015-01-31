//
//  PollPushManager.h
//  ggrt
//
//  Created by Jerry Yu on 2015-01-31.
//  Copyright (c) 2015 Jerry Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const kGGRTUpdateNotification = @"kGGRTUpdateNotification";

@interface PollPushManager : NSObject

+ (void)start;

+ (void)updateNow;

+ (void)setDeviceToken:(NSData *)deviceToken;

@end
