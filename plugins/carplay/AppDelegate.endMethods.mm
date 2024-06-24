- (BOOL)initAppFromScene:(UISceneConnectionOptions *)connectionOptions {
    // If bridge has already been initiated by another scene, there's nothing to do here
    if (self.bridge != nil) {
        return NO;
    }

    if (self.bridge == nil) {
      self.bridge = [self createBridgeWithDelegate:self
                                launchOptions:[self connectionOptionsToLaunchOptions:connectionOptions]];
    }

    NSDictionary * initProps = [self prepareInitialProps];
    self.rootView = [self  createRootViewWithBridge:self.bridge moduleName:self.moduleName initProps:initProps];

    self.rootView.backgroundColor = [UIColor blackColor];

    return YES;
}

- (NSDictionary<NSString *, id> *)prepareInitialProps {
    NSMutableDictionary<NSString *, id> *initProps = [self.initialProps mutableCopy] ?: [NSMutableDictionary dictionary];
#if RCT_NEW_ARCH_ENABLED
    initProps[@"kRNConcurrentRoot"] = [self concurrentRootEnabled];
#endif
    return [initProps copy];
}

- (NSDictionary<UIApplicationLaunchOptionsKey, id> *)connectionOptionsToLaunchOptions:(UISceneConnectionOptions *)connectionOptions {
    NSMutableDictionary<UIApplicationLaunchOptionsKey, id> *launchOptions = [NSMutableDictionary dictionary];

    if (connectionOptions) {
        if (connectionOptions.notificationResponse) {
            launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey] = connectionOptions.notificationResponse.notification.request.content.userInfo;
        }

        if ([connectionOptions.userActivities count] > 0) {
            NSUserActivity* userActivity = [connectionOptions.userActivities anyObject];
            NSDictionary *userActivityDictionary = @{
                @"UIApplicationLaunchOptionsUserActivityTypeKey": [userActivity activityType] ? [userActivity activityType] : [NSNull null],
                @"UIApplicationLaunchOptionsUserActivityKey": userActivity ? userActivity : [NSNull null]
            };
            launchOptions[UIApplicationLaunchOptionsUserActivityDictionaryKey] = userActivityDictionary;
        }
    }

    return launchOptions;
}