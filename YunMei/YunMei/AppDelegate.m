//
//  AppDelegate.m
//  YunMei
//
//  Created by zhengjiang on 15-1-5.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import "SortViewController.h"

#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   /*
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    
    IndexViewController *indexController=[[IndexViewController alloc]initWithNibName:@"IndexViewController" bundle:nil];
    
    navigationController=[[UINavigationController alloc]initWithRootViewController:indexController];
    //[navigationController.navigationBar setHidden:true];
    
    [ self.window setRootViewController:navigationController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
    */
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupViewControllers];
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    
    [self customizeInterface];
    
    return YES;

}



#pragma mark - Methods

- (void)setupViewControllers {
    IndexViewController *firstViewController = [[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    UINavigationController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    firstNavigationController.navigationBar.tintColor=[Utils colorWithHexString:@"#86B9D8"];
    
    SendAdViewController *secondViewController = [[SendAdViewController alloc] initWithNibName:@"SendAdViewController" bundle:nil];
    UINavigationController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    SortViewController *thirdViewController = [[SortViewController alloc] initWithNibName:@"SortViewController" bundle:nil];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    
    CartViewController *fourViewController = [[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil];
    UINavigationController *forNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:fourViewController];
    
    PersonalViewController *FivfiewController = [[PersonalViewController alloc] initWithNibName:@"PersonalViewController" bundle:nil];
    UIViewController *fivNavigationController = [[UINavigationController alloc]
                                                 initWithRootViewController:FivfiewController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,
                                           thirdNavigationController,forNavigationController,fivNavigationController]];
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
    
    //tabBarController.navigationController.navigationBar.tintColor=[Utils colorWithHexString:@"#86B9D8"];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"1-1_18", @"1-1_19", @"1-1_20", @"1-1_21", @"1-1_22"];
    NSArray *tabBarItemImagesselected = @[@"1-1_03", @"1-1_05", @"1-1_07", @"1-1_09", @"1-1_11"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[tabBarItemImagesselected objectAtIndex:index]];
        UIImage *unselectedimage = [UIImage imageNamed:[tabBarItemImages objectAtIndex:index]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
    
}

- (void)customizeInterface {
     UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    /*
    [navigationBarAppearance setBarTintColor:COLOR_NAVIGATIONBAR_TINTCOLER];
    [navigationBarAppearance setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: COLOR_NAVIGATIONBAR_BACK_COLOR,UITextAttributeFont : [UIFont boldSystemFontOfSize:20]
                                                           }];
    */
    
    
   
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor whiteColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor whiteColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    
    //[navigationBarAppearance setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [navigationBarAppearance setBarTintColor:COLOR_NAVIGATIONBAR_TINTCOLER];
    
    navigationBarAppearance.translucent =YES;
     
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
