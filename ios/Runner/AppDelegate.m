#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
//DISABLE_PUSH_NOTIFICATIONS=1禁止推送
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIImageView *launchImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Launch"]];
    launchImage.frame=[UIScreen mainScreen].bounds;
    launchImage.contentMode=UIViewContentModeScaleAspectFill;
    [self.window addSubview:launchImage];
    [GeneratedPluginRegistrant registerWithRegistry:self];
    self.window.rootViewController.view.alpha = 0;
    [self performSelector:@selector(cancel) withObject:nil afterDelay:1];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
-(void)cancel{
    self.window.rootViewController.view.alpha = 1;
}


@end

