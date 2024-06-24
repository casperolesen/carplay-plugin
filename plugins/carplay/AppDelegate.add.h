#import <Foundation/Foundation.h>
#import <ExpoModulesCore/EXReactDelegateWrapper.h>
#import <React_RCTAppDelegate/RCTAppDelegate.h>

@interface AppDelegate : RCTAppDelegate

@property (nonatomic, strong, readonly) EXReactDelegateWrapper *reactDelegate;
@property (nonatomic, strong) UIView *rootView;
@property (nonatomic, strong) UIViewController *rootViewController;

- (BOOL)initAppFromScene:(UISceneConnectionOptions *)connectionOptions;

- (void)finishedLaunchingWithOptions:(UISceneConnectionOptions *)connectionOptions;