//
//  RegisterViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-12.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "RegisterInfoViewController.h"
#import "UCSVerifyService.h"

@interface RegisterViewController : BaseSecondViewController<UITextFieldDelegate,UCSVerifyEventDelegate,NSURLConnectionDataDelegate>

@property(strong,nonatomic) IBOutlet UITextField *txtPhone;
@property(strong,nonatomic) IBOutlet UITextField *txt_code;
@property(strong,nonatomic)IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain)UCSVerifyService *ucs;

@end
