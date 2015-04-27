//
//  MoneyBaseViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-12.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseSecondViewController.h"

@interface MoneyBaseViewController : BaseSecondViewController

@property(strong,nonatomic)IBOutlet UIScrollView *scrollView;

@property(strong,nonatomic)IBOutlet UILabel *txtTatol;
@property(strong,nonatomic)IBOutlet UILabel *txtFuns;
@property(strong,nonatomic)IBOutlet UILabel *txtAdvert;
@property(strong,nonatomic)IBOutlet UILabel *txtGive;
@property(strong,nonatomic)IBOutlet UILabel *txtUsed;

@end
