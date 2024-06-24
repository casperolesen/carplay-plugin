// CarPlay specific
#import "CarSceneDelegate.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "RNCarPlay.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>
#import <EXSplashScreen/EXSplashScreenService.h>

@implementation CarSceneDelegate


- (void)templateApplicationScene:(CPTemplateApplicationScene *)templateApplicationScene 
    didConnectInterfaceController:(CPInterfaceController *)interfaceController 
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     
    [appDelegate initAppFromScene: nil];

    [RNCarPlay connectWithInterfaceController:interfaceController window:templateApplicationScene.carWindow];    
}


- (void)templateApplicationScene:(CPTemplateApplicationScene *)templateApplicationScene didDisconnectInterfaceController:(CPInterfaceController *)interfaceController
{
    [RNCarPlay disconnect];
}

@end
