//
//  SortViewController.h
//  YunMei
//
//  Created by  macbook on 15-1-13.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "BaseViewController.h"

#import "SortJDViewController.h"
#import "SortFSViewController.h"
#import "SortGMViewController.h"
#import "SortGGViewController.h"
#import "SortCPViewController.h"
#import "SortYBViewController.h"

@interface SortViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (nonatomic, strong) IBOutlet UITableView *tableViewList;

@end
