//
//  CartViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface CartViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
 NSMutableArray *selectIds;
  NSMutableArray *listeDate;
    NSMutableArray *checkBoxs;
}

@property (nonatomic, strong) IBOutlet UITableView *tableViewList;
@property(strong,nonatomic)IBOutlet UILabel *lblTotolPrice;

@end
