//
//  AppDelegate.m
//  AD
//
//  Created by 斌 on 12-12-3.
//  Copyright (c) 2012年 斌. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import "ViewControllers.h"
@implementation AppDelegate


- (void)initilalizePlat {
    //SinaWeibo
   [ShareSDK connectSinaWeiboWithAppKey:SinaWeiboAppKey appSecret:SinaWeiboAppSecret redirectUri:SinaWeiboRedirectURI];
    
    //TencentWeibo
    [ShareSDK connectTencentWeiboWithAppKey:TencentWeiboAppKey appSecret:TencentWeiboAppSecret redirectUri:TencentWeiboRedirectURI];
    //QZone
    [ShareSDK connectQZoneWithAppKey:QZoneAppKey appSecret:QZoneAppSecret];
    
    //QQ
    [ShareSDK connectQQWithAppId:QQApiID qqApiCls:[QQApi class]];
    
    //KaiXin
    [ShareSDK connectKaiXinWithAppKey:KaiXinAppKey appSecret:KaiXinAppSecret redirectUri:KaiXinAppRedirectURI];
    
    //RenRen
    [ShareSDK connectRenRenWithAppKey:RenRenAppKey appSecret:RenRenAppSecret];

    //WeiChat
    [ShareSDK connectWeChatWithAppId:WeiChatAppKey wechatCls:[WXApi class]];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //设置应用Api信息
    [AibangApi setAppkey:APP_KEY];
    
    [ShareSDK registerApp:ShareSDKAppKey];
    [ShareSDK convertUrlEnabled:YES];
    [self initilalizePlat];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    ViewControllers *viewControllers = [[ViewControllers alloc] initWithTitle:nil
                                                                   tabBarSize:(CGSize){kKYTabBarWdith, kKYTabBarHeight}
                                                        tabBarBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:kKYITabBarBackground]]
                                                                     itemSize:(CGSize){kKYTabBarItemWidth, kKYTabBarItemHeight}
                                                                        arrow:[UIImage imageNamed:kKYITabBarArrow]];
    self.window.rootViewController = viewControllers;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
