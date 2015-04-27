//
//  AboutViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-11.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize myWebView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    myWebView.delegate=self;
    NSString *path=[[NSBundle mainBundle]pathForResource:@"us" ofType:@"html"];
    NSString *html=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [myWebView loadHTMLString:html baseURL:[NSURL URLWithString:path]];}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
