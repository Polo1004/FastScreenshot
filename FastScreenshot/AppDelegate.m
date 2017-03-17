//
//  AppDelegate.m
//  FastScreenshot
//
//  Created by GQuEen on 17/2/28.
//  Copyright © 2017年 GegeChen. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AboutViewController.h"

@interface AppDelegate ()

@property (strong, nonatomic) ViewController *vc;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    _window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, MAIN_SCREEN_WIDTH, MAIN_SCREEN_HEIGHT)];
    
    _vc = [[ViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.vc];
    _window.rootViewController = nav;
    [_window makeKeyAndVisible];
    
    [self setYMkey];
    // Override point for customization after application launch.
    return YES;
}

- (void)setYMkey {
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:YM_SHARE_APP_KEY];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:YM_WEIXIN_APP_ID appSecret:YM_WEIBO_APP_SECRET redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:YM_QQ_APP_ID  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:YM_WEIBO_APP_KEY  appSecret:YM_WEIBO_APP_SECRET redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    if ([[url absoluteString] hasPrefix:@"widget"]) {
        if ([[url host] isEqualToString:@"weibo"]) {
            NSLog(@"点击了 widget中的weibo");
            [_vc shareToPlatformType:0];
        }else if ([[url host] isEqualToString:@"weixin"]) {
            NSLog(@"点击了 widget中的weixin");
            [_vc shareToPlatformType:1];
        }else if ([[url host] isEqualToString:@"QQ"]) {
            NSLog(@"点击了 widget中的QQ");
            [_vc shareToPlatformType:4];
        }else if ([[url host] isEqualToString:@"moment"]) {
            NSLog(@"点击了 widget中的朋友圈");
            [_vc shareToPlatformType:2];
        }
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
