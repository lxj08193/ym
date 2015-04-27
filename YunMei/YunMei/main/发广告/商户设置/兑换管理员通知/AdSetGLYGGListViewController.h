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

@interface AdSetGLYGGListViewController : BaseSecondViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *listeDate;
}

@property (nonatomic, strong) IBOutlet UITableView *tableViewList;

@end
