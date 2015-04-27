//
//  AdSPAddViewController.h
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSecondViewController.h"
#import "SPTypeTreeViewController.h"
#import "BDDynamicTreeNode.h"

@interface AdSPAddViewController : BaseSecondViewController<UIGestureRecognizerDelegate,UIActionSheetDelegate>{


     int sh;
    NSString *currtypeId;
    UIImageView *cureeImageView;
}


@property(strong,nonatomic)IBOutlet UIScrollView *scrollView;


@property(strong,nonatomic)IBOutlet UITextField *adName;

@property(strong,nonatomic)IBOutlet UIImageView *adImageF;
@property(strong,nonatomic)IBOutlet UIImageView *adImage1;
@property(strong,nonatomic)IBOutlet UIImageView *adImage2;
@property(strong,nonatomic)IBOutlet UIImageView *adImage3;
@property(strong,nonatomic)IBOutlet UIImageView *adImage4;
@property(strong,nonatomic)IBOutlet UITextView  *adIntros;
@property(strong,nonatomic)IBOutlet UITextField *adLink;
@property(strong,nonatomic)IBOutlet UIButton *adType;

@property(strong,nonatomic)IBOutlet UITextField *adCount;
@property(strong,nonatomic)IBOutlet UITextField *adPrice1;
@property(strong,nonatomic)IBOutlet UITextField *adPrice2;

-(IBAction)saveAction:(id)sender;
-(IBAction)selectTypeAction:(id)sender;
@end
