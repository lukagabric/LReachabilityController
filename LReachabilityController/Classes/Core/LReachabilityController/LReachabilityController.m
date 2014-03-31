//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import "LReachabilityController.h"


@implementation LReachabilityController


@synthesize availableViaWiFi = _availableViaWiFi;
@synthesize availableViaWWAN = _availableViaWWAN;
@synthesize internetAvailable = _internetAvailable;


#pragma mark - Singleton


+ (LReachabilityController *)sharedReachabilityController
{
	__strong static LReachabilityController *sharedReachabilityController = nil;
    
	static dispatch_once_t onceToken;
    
	dispatch_once(&onceToken, ^{
        sharedReachabilityController = [LReachabilityController new];
    });
    
	return sharedReachabilityController;
}


#pragma mark - dealloc


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - startReachability


- (void)startReachability
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _reachability = [Reachability reachabilityForInternetConnection];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [_reachability startNotifier];
        });
        
        NetworkStatus netStatus = [_reachability currentReachabilityStatus];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setStatus:netStatus];
        });
    });
}


- (void)reachabilityChanged:(NSNotification *)note
{
	Reachability *curReach = [note object];
    
	NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
	[self setStatus:netStatus];
}


- (void)setStatus:(NetworkStatus)netStatus
{
	switch (netStatus)
	{
		case ReachableViaWWAN :
		{
			_availableViaWWAN = YES;
			_internetAvailable = YES;
			_availableViaWiFi = NO;
			break;
		}
		case ReachableViaWiFi :
		{
			_availableViaWiFi = YES;
			_internetAvailable = YES;
			_availableViaWWAN = NO;
			break;
		}
		case NotReachable :
		{
			_internetAvailable = NO;
			_availableViaWiFi = NO;
			_availableViaWWAN = NO;
			break;
		}
	}
    
#if DEBUG
    NSLog(@"Internet available = %@", _internetAvailable ? @"YES" : @"NO");
#endif
    
    _reachabilityKnown = YES;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kReachabilityControllerStatusChanged object:self];
}


@end