//
//  AdAppViewController.h
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSecondViewController.h"
#import "AdSPListViewController.h"
#import "AdSPAddViewController.h"

@interface AdSPViewController : BaseSecondViewController<UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (nonatomic, strong) IBOutlet UITableView *tableViewList;

@end
