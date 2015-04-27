//
//  AboutViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-11.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseSecondViewController.h"
@interface AboutViewController : BaseSecondViewController<UIWebViewDelegate>

@property(strong)IBOutlet UIWebView *myWebView;

@end
