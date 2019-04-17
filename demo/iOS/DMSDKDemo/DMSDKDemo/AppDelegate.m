//
//  AppDelegate.m
//  TvsLoginDemo
//
//  Created by Rinc Liu on 2019/1/28.
//  Copyright © 2019 tencent. All rights reserved.
//

#import "AppDelegate.h"
#import <TVSCore/TVSCore.h>
#import "BrowserVC.h"

@implementation AppDelegate

//SDK 初始化
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[TVSEnvironment shared]enableLog];//开启日志
    [[TVSAuthManager shared]registerApp];//读取配置信息
    return YES;
}

//处理 微信/QQ 等 URL 跳转
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 处理微信/QQ 登录跳转
    if ([[TVSAuthManager shared] handleOpenUrl:url]) return YES;
    // 处理云叮当 APP 授权后的 URL 回跳
    /*if ([url.host isEqualToString:@"tvs-auth"] && [url.query isEqualToString:@"result=0"]) {
        // 打开第三方授权网页
        BrowserVC* bv = [BrowserVC new];
        bv.pageType = TVSWebPageTypeThirdPartyAuth;
        [(UINavigationController*)(self.window.rootViewController) pushViewController:bv animated:YES];
    }*/
    return NO;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
