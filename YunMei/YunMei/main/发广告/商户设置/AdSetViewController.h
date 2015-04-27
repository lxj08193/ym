//
//  AdAppViewController.h
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSecondViewController.h"
#import "AdSetGLYGGListViewController.h"
#import "AdSetGGListViewController.h"
#import "AdSetXXListViewController.h"
#import "AdSetWTListViewController.h"
#import "AdSetFKViewController.h"
@interface AdSetViewController : BaseSecondViewController<UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (nonatomic, strong) IBOutlet UITableView *tableViewList;

@end
