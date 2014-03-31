//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import "ViewController.h"


@implementation ViewController


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachChanged) name:kReachabilityControllerStatusChanged object:nil];
    }
    return self;
}


- (void)reachChanged
{
    NSLog(@"Internet available = %@", [[LReachabilityController sharedReachabilityController] internetAvailable] ? @"YES" : @"NO");
}


@end