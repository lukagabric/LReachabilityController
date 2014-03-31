//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#define kReachabilityControllerStatusChanged @"kReachabilityControllerStatusChanged"
#define isInternetAvailable [[LReachabilityController sharedReachabilityController] internetAvailable]


#import "Reachability.h"


@interface LReachabilityController : NSObject
{
	BOOL _reachabilityKnown;

	Reachability *_reachability;
	BOOL _internetAvailable;
	BOOL _availableViaWiFi;
	BOOL _availableViaWWAN;
}


@property (nonatomic, readonly) BOOL internetAvailable;
@property (nonatomic, readonly) BOOL availableViaWiFi;
@property (nonatomic, readonly) BOOL availableViaWWAN;


+ (LReachabilityController *)sharedReachabilityController;


- (void)startReachability;


@end