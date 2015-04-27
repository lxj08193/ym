//
//  ModelController.h
//  YunMei
//
//  Created by  macbook on 15-1-4.
//  Copyright (c) 2015年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataViewController;

@interface ModelController : NSObject <UIPageViewControllerDataSource>

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(DataViewController *)viewController;

@end

