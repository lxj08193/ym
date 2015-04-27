//
//  SortViewController.h
//  YunMei
//
//  Created by  macbook on 15-1-13.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseSecondViewController.h"
#import "SFRZViewController.h"
#import "AddressViewController.h"
#import "ResetPasswordViewController.h"
#import "SJYZViewController.h"
#import "AdGGViewController.h"
@interface CSetViewController : BaseSecondViewController<UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (nonatomic, strong) IBOutlet UITableView *tableViewList;

@end
