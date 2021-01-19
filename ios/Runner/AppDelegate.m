#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  [GMSServices provideAPIKey:@"{{AIzaSyBYlx-jwVmGxM5ri5EMYkmO2DAwT6kOPV0}}"];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
