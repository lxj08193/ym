//
//  IndexViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-3.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ShopListViewController.h"
#import "PersonalViewController.h"
#import "CartViewController.h"
#import "SendAdViewController.h"
#import "MyShopViewController.h"
#import "FXViewController.h"
#import "HDViewController.h"
#import "JYViewController.h"

#import "MBTitleView.h"

@interface IndexViewController : BaseViewController<MBTitleViewDelegate>
{
    NSMutableArray *images;
    NSMutableArray *arrayImageObj;
    MBTitleView *titleView;
}

@property(strong) IBOutlet UIButton *btnImage;

@property(strong) IBOutlet UIView *mBTitleView;

-(IBAction)jtpAction:(id)sender;
-(IBAction)ykAction:(id)sender;
-(IBAction)scAction:(id)sender;
-(IBAction)shopAction:(id)sender;
-(IBAction)hdAction:(id)sender;
-(IBAction)fxAction:(id)sender;
-(IBAction)jyAction:(id)sender;
@end
