//
//  AppDelegate.m
//  22222
//
//  Created by 玉岳鹏 on 2018/7/5.
//  Copyright © 2018年 玉岳鹏. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "ViewController.h"
#import "IFlyMSC/IFlyMSC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [IFlySetting setLogFile:LVL_ALL];
    
    //Set whether to output log messages in Xcode console
    [IFlySetting showLogcat:YES];
    
    //Set the local storage path of SDK
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];

    //Set APPID
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"5b359cb2"];
    
    //Configure and initialize iflytek services.(This interface must been invoked in application:didFinishLaunchingWithOptions:)
    [IFlySpeechUtility createUtility:initString];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UITabBarController *tab = [[UITabBarController alloc] init];
    ViewController *vc = [[ViewController alloc] init];
    [tab addChildViewController:vc];
   
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:tab];
    //    [tab setViewControllers:@[vc]];
    
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
    int n = 11;
    int a[n];
    for (int i = 0; i < 11; i ++) {
        a[i] = i + 1;
    }
    for (int i = 0; i < (n + 1)/2 ; i ++) {
        int temp = a[i];
        a[i] = a[n - i - 1];

        a[n - 1 - i] = temp;
    }
    for (int i = 0; i < n; i ++) {
        printf("int === %d",a[i]);
        
    }
    [self seekRandomThreeElementSum:5 Arr:@[@(1),@(2),@(4),@(5),@(6),@(7),@(3)]];//没有
    [self seekRandomThreeElementSum:6 Arr:@[@(1),@(2),@(3),@(4),@(5),@(6),@(7)]];//有
    [self seekRandomThreeElementSum:7 Arr:@[@(1),@(4),@(3),@(5),@(6),@(7)]];//没有
    [self seekRandomThreeElementSum:8 Arr:@[@(1),@(4),@(3),@(5),@(6),@(7)]];//有
    [self seekRandomThreeElementSum:3 Arr:@[@(1),@(4),@(3),@(5),@(6),@(7)]];//没有

    return YES;
}
- (BOOL)seekRandomThreeElementSum:(NSInteger)sum Arr:(NSArray *)array {
    NSInteger b,c,d,i,j,k;
    
    for (i = 0; i < array.count; i ++) {
        b = [array[i] integerValue];
        for (j = 0 ; j < array.count; j ++) {
            if (j != i) {
                c = [array[j] integerValue];
                for (k = 0; k < array.count; k ++) {
                    if (k != i && k != j) {
                        d = [array[k] integerValue];
                        if (b + c + d == sum) {
                            NSLog(@"have the sum");
                            return YES;
                        }
                    }
                }
            }
        }
    }
    NSLog(@"have not the sum");
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
