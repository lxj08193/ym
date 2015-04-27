//
//  SmallMoneyViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-12.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseSecondViewController.h"

@interface SmallMoneyViewController :  BaseSecondViewController

@property(strong) NSDictionary *dicAdvert;

@property(strong,nonatomic)IBOutlet UIScrollView *scrollView;
@property(strong,nonatomic)IBOutlet UIImageView *imgAdvert;
@property(strong,nonatomic)IBOutlet UITextView *txtAdvert;
@property(strong,nonatomic)IBOutlet UITextView *txtDes;
@property(strong,nonatomic)IBOutlet UIButton *btnGet;

@end
