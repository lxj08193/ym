//
//  CollectionSpController.h
//  YunMei
//
//  Created by XingJian Li on 15-1-22.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSecondViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
@interface CollectionGGController : BaseSecondViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *listeDate;
}

@property (nonatomic, strong) IBOutlet UITableView *tableViewList;


@end
