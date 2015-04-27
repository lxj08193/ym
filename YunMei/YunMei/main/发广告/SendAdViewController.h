//
//  SendAdViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-10.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseViewController.h"

#import "AdSetViewController.h"
#import "AdXJViewController.h"
#import "AdGGViewController.h"
#import "AdJZViewController.h"
#import "AdSPViewController.h"
#import "AdXSViewController.h"


@interface SendAdViewController : BaseViewController

-(IBAction)shszAction:(id)sender;
-(IBAction)xjyzAction:(id)sender;
-(IBAction)ggglAction:(id)sender;
-(IBAction)zztfAction:(id)sender;
-(IBAction)xsglAction:(id)sender;
-(IBAction)spglAction:(id)sender;

@property(strong)IBOutlet UIImageView *imgHead;
@property(strong,nonatomic)IBOutlet UILabel *lblName;
@property(strong,nonatomic)IBOutlet UILabel *lblGold;
@property(strong,nonatomic)IBOutlet UILabel *lblAdNum;
@property(strong,nonatomic)IBOutlet UILabel *lblAdOverNum;

@end
