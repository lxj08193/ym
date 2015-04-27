//
//  AdvertListViewController.h
//  YunMei
//
//  Created by  macbook on 15-1-30.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "BaseSecondViewController.h"

@interface AdvertListViewController : BaseSecondViewController<UITableViewDelegate,UITableViewDataSource>


@property(strong,nonatomic)IBOutlet UITableView *myTableView;
@property(strong,nonatomic)IBOutlet UISegmentedControl *mySegCtrl;

@end
