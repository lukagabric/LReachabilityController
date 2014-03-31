LReachabilityController
=======================

iOS Reachability Controller

Singleton object with helper methods and extensions on Reachability class.

Implementation
--------------

In application delegate method -application:didFinishLaunchingWithOptions: start reachability notifier.

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
        [[LReachabilityController sharedReachabilityController] startReachability];
    }
    
Notification is sent on reachability changed. Sample implementation:

    - (instancetype)init
    {
        self = [super init];
        if (self)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachChanged) name:kReachabilityChangedNotification object:nil];
        }
        return self;
    }


    - (void)reachChanged
    {
        NSLog(@"Internet available = %@", [[LReachabilityController sharedReachabilityController] internetAvailable] ? @"YES" : @"NO");
    }
