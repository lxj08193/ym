//
//  MyDetailViewController.h
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSecondViewController.h"

#import "CustomURLCache.h"
#import "Reachability.h"

@interface MyDetailViewController : BaseSecondViewController<UIWebViewDelegate>
@property(nonatomic,strong)IBOutlet UIWebView *webview;
@property(strong)NSString *url;
@end
