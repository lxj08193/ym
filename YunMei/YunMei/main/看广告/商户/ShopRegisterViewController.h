//
//  ShopRegisterViewController.h
//  YunMei
//
//  Created by  macbook on 15-1-24.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "BaseSecondViewController.h"

@interface ShopRegisterViewController :BaseSecondViewController <UIActionSheetDelegate>

@property(strong,nonatomic)IBOutlet UIButton *imageViewBack;
@property(strong,nonatomic)IBOutlet UITextField *txtName;
@property(strong,nonatomic)IBOutlet UITextField *txtPeople;
@property(strong,nonatomic)IBOutlet UITextField *txtTel;
@property(strong,nonatomic)IBOutlet UITextField *txtAddress;
@property(strong,nonatomic)IBOutlet UIScrollView *scrollView;
@property(strong,nonatomic)IBOutlet UITextView *txtIntroduce;

@end
