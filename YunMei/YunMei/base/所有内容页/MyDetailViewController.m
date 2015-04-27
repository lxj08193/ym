//
//  MyDetailViewController.m
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import "MyDetailViewController.h"

@interface MyDetailViewController ()

@end

@implementation MyDetailViewController
@synthesize webview,url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        CustomURLCache *urlCache = [[CustomURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                                                     diskCapacity:200 * 1024 * 1024
                                                                         diskPath:nil
                                                                        cacheTime:0];
        [CustomURLCache setSharedURLCache:urlCache];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    //没有网络
    if (![Reachability networkAvailable]) {
        [SVProgressHUD showErrorWithStatus:@"当前网络不可用"];
        return;
    }
    
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//关闭状态栏动画

    [webview stopLoading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    CustomURLCache *urlCache = (CustomURLCache *)[NSURLCache sharedURLCache];
    [urlCache removeAllCachedResponses];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    //[SVProgressHUD show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//关闭状态栏动画
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
    //[SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;//关闭状态栏动画
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    /*
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
     hud.mode = MBProgressHUDModeIndeterminate;
     hud.labelText = @"Loading...";
     */
    //[SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;//开启状态栏动画

}
@end
