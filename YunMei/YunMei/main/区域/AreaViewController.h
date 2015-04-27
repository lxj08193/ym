//
//  AreaViewController.h
//  YunMei
//
//  Created by  macbook on 15-1-27.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "BaseSecondViewController.h"
#import <UIKit/UIKit.h>

@protocol AreaDelegate<NSObject>

-(void)ReturnArea:(NSDictionary *)area;

@end

@interface AreaViewController : BaseSecondViewController<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)IBOutlet UITableView *myTableView;

@property(strong) NSObject<AreaDelegate> *delegate;

@end
