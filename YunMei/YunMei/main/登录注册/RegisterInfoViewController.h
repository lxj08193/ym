//
//  RegisterInfoViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-12.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "IndexViewController.h"

@interface RegisterInfoViewController : BaseSecondViewController

@property(strong,nonatomic)IBOutlet UITextField* txtPhone;
@property(strong,nonatomic)IBOutlet UITextField* txtPwd;
@property(strong,nonatomic)IBOutlet UITextField* txtRePwd;
@property(strong,nonatomic)IBOutlet UIScrollView *scrollView;

@property(strong) NSString *flag;
@property(strong) NSString *phone;

@end
