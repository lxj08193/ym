//
//  AppDelegate.h
//  YunMei
//
//  Created by zhengjiang on 15-1-5.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;
@property (nonatomic, retain) NSHTTPCookie *cookie;
@property(assign)  int userCode;
@property(assign)  int peopleId;
@end
