//
//  AddressViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseSecondViewController.h"
#import "AddressEditViewController.h"

@interface AddressViewController : BaseSecondViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong)IBOutlet UITableView *tableViewList;

@end
