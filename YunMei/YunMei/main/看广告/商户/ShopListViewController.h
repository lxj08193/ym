//
//  ShopListViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSecondViewController.h"

@interface ShopListViewController : BaseSecondViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)IBOutlet UITableView *myTableView;
@property(strong) NSString *find;

@end
