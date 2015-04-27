//
//  SortViewController.h
//  YunMei
//
//  Created by  macbook on 15-1-13.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "BaseSecondViewController.h"

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "AdGGAddViewController.h"
@interface AdGGListViewController : BaseSecondViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *listeDate;
    NSInteger page;
}

@property (nonatomic, strong) IBOutlet UITableView *tableViewList;
@property (assign) int state;
@end
