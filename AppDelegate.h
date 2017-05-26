//
//  AppDelegate.h
//  FileManager
//
//  Created by zhu_sl on 2017/5/25.
//  Copyright © 2017年 zhu_sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HTTPServer * httpServer;

+ (AppDelegate *)appDelegate;

- (void)startServer;

@end

