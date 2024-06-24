@interface AppDelegate()

@property (nonatomic, strong) EXReactDelegateWrapper *reactDelegate;

@end

@implementation AppDelegate {
    EXExpoAppDelegate *_expoAppDelegate;
}


- (instancetype)init
{
    if (self = [super init]) {
        _expoAppDelegate = [[EXExpoAppDelegate alloc] init];
        _reactDelegate = [[EXReactDelegateWrapper alloc] initWithExpoReactDelegate:_expoAppDelegate.reactDelegate];
    }
    return self;
}


// This needs to be implemented, otherwise forwarding won't be called.
// When the app starts, \`UIApplication\` uses it to check beforehand
// which \`UIApplicationDelegate\` selectors are implemented.
- (BOOL)respondsToSelector:(SEL)selector
{
    return [super respondsToSelector:selector]
        || [_expoAppDelegate respondsToSelector:selector];
}

// Forwards all invocations to \`ExpoAppDelegate\` object.
- (id)forwardingTargetForSelector:(SEL)selector
{
    return _expoAppDelegate;
}


- (UIView *)findRootView:(UIApplication *)application
{
    UIWindow *mainWindow = application.delegate.window;
    if (mainWindow == nil) { 
        return nil;
    }
    UIViewController *rootViewController = mainWindow.rootViewController;
    if (rootViewController == nil) {
        return nil;
    }
    UIView *rootView = rootViewController.view;
    return rootView;
}


- (RCTBridge *)createBridgeWithDelegate:(id<RCTBridgeDelegate>)delegate launchOptions:(NSDictionary *)launchOptions
{
    return [self.reactDelegate createBridgeWithDelegate:delegate launchOptions:launchOptions];
}

- (UIView *)createRootViewWithBridge:(RCTBridge *)bridge
                        moduleName:(NSString *)moduleName
                            initProps:(NSDictionary *)initProps
{
    BOOL enableFabric = NO;
    #if RN_FABRIC_ENABLED
    enableFabric = self.fabricEnabled;
    #endif

    return [self.reactDelegate createRootViewWithBridge:bridge
                                            moduleName:moduleName
                                    initialProperties:initProps
                                        fabricEnabled:enableFabric];
}

- (UIViewController *)createRootViewController
{
    self.rootViewController =  [self.reactDelegate createRootViewController];
    return self.rootViewController;
}

- (void)finishedLaunchingWithOptions:(UISceneConnectionOptions *)connectionOptions
{ 
  [_expoAppDelegate application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:[self connectionOptionsToLaunchOptions:connectionOptions]];
}