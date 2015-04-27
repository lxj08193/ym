//
//  ShopViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseSecondViewController.h"

@interface ShopViewController : BaseSecondViewController<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property(nonatomic,retain)IBOutlet UITableView *myTableView;
//@property(nonatomic,retain)IBOutlet UIWebView *myWebView;
@end
