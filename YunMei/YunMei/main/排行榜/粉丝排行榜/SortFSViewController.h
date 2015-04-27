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

@interface SortFSViewController : BaseSecondViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *listeDate;
}

@property (nonatomic, strong) IBOutlet UITableView *tableViewList;
@property(strong) NSString *condition;
@property(strong) NSString *url;
@property(assign)int flag;
@property(assign)int viewType;

@end
