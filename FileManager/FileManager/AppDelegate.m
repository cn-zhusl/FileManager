//
//  AppDelegate.m
//  FileManager
//
//  Created by zhu_sl on 2017/5/25.
//  Copyright © 2017年 zhu_sl. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)appDelegate{
    
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [AppDelegate appDelegate].httpServer = [[HTTPServer alloc] init];
    [[AppDelegate appDelegate].httpServer setType:@"_http._tcp."];
    [[AppDelegate appDelegate].httpServer setConnectionClass:[MyHTTPConnection class]];
    [[AppDelegate appDelegate].httpServer setPort:55693];
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    NSLog(@"Setting document root: %@", webPath);
    
    [[AppDelegate appDelegate].httpServer setDocumentRoot:webPath];

    
    return YES;
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


- (void)startServer
{
    // Start the server (and check for problems)
    
    NSError *error;
    if([[AppDelegate appDelegate].httpServer start:&error])
    {
        NSLog(@"Started HTTP Server on port %hu", [[AppDelegate appDelegate].httpServer listeningPort]);
    }
    else
    {
        NSLog(@"Error starting HTTP Server: %@", error);
    }
}

@end
