//
//  AdSPAddViewController.h
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSecondViewController.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface MyShopViewController : BaseSecondViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *listeDate;
}

@property (nonatomic, strong) IBOutlet UITableView *tableViewList;
@property(strong,nonatomic)IBOutlet UIButton *btnSortByPrice;
@property(strong,nonatomic)IBOutlet UIButton *btnSortByDiscountPrice;

@end
