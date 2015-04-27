//
//  PersonalViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "BookListViewController.h"
#import "AddressViewController.h"
#import "AboutViewController.h"
#import "CSetViewController.h"
#import "UserUpDataViewController.h"
#import "SourceViewController.h"


@interface PersonalViewController : BaseViewController

@property(nonatomic,retain)IBOutlet UIButton *userButton;

@property(nonatomic,retain)IBOutlet UIImageView *imgUserHead;

@property(strong,nonatomic)IBOutlet UIScrollView *scrollView;

-(IBAction)sourceAction:(id)sende;
-(IBAction)setAction:(id)sende;

-(IBAction)userAction:(id)sende;
@end
