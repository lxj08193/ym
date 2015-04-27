//
//  AdSPAddViewController.h
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSecondViewController.h"

#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
//#import "CalendarDayModel.h"
#import "Color.h"

#import "AdTypeTreeViewController.h"
#import "AdTypeTreeViewController.h"
#import "BDDynamicTreeNode.h"

@interface AdJZAddViewController : BaseSecondViewController<UIGestureRecognizerDelegate,UIActionSheetDelegate>
{

    int sh;
    UIImageView *cureeImageView;
    CalendarHomeViewController *chvc;
     NSString *currtypeId;
    
    NSDate *startDateCurr;
    NSDate *endDateCurr;
}
@property(strong,nonatomic) NSDictionary *adNSDictionary;

@property(strong,nonatomic)IBOutlet UIScrollView *scrollView;

@property(strong,nonatomic)IBOutlet UITextField *adName;
@property(strong,nonatomic)IBOutlet UITextField *adTitle;

@property(strong,nonatomic)IBOutlet UIImageView *adImageF;
@property(strong,nonatomic)IBOutlet UIImageView *adImage1;
@property(strong,nonatomic)IBOutlet UIImageView *adImage2;
@property(strong,nonatomic)IBOutlet UIImageView *adImage3;
@property(strong,nonatomic)IBOutlet UIImageView *adImage4;
@property(strong,nonatomic)IBOutlet UITextView  *adIntros;
@property(strong,nonatomic)IBOutlet UITextField *adLink;
@property(strong,nonatomic)IBOutlet UIButton *adStartDate;
@property(strong,nonatomic)IBOutlet UIButton *adEndDate;
@property(strong,nonatomic)IBOutlet UIButton *adType;
@property(strong,nonatomic)IBOutlet UIButton *saveButton;

@property(strong,nonatomic)IBOutlet UITextField *adCount;

-(IBAction)dateAction:(id)sender;
-(IBAction)saveAction:(id)sender;
-(IBAction)selectTypeAction:(id)sender;
@end
