//
//  ShopViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()
{
    NSMutableArray *datas;
    NSString *path;
    NSString *html;
    UIWebView *myWebView;
}

@end

@implementation ShopViewController
@synthesize myTableView;

- (void)viewDidLoad {
    //self.view.frame.size.width
    [super viewDidLoad];

    myTableView.separatorStyle=NO;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    datas=[[NSMutableArray alloc]initWithCapacity:0];
    [datas addObject:@"1"];
    myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    myWebView.delegate=self;
    path=[[NSBundle mainBundle]pathForResource:@"Shop" ofType:@"html"];
    html=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [myWebView loadHTMLString:html baseURL:[NSURL URLWithString:path]];
    [myTableView reloadData];
}

-(IBAction)Select:(id)sender
{
    
    UIButton *btn=sender;
    [btn setBackgroundColor:[[UIColor alloc] initWithRed:233 green:233 blue:233 alpha:1]];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    float height=[[myWebView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"]floatValue];
    myWebView.frame=CGRectMake(-5, -10, self.view.frame.size.width, height+5);
    [[[myWebView subviews]lastObject]setScrollEnabled:false];
    [myTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return myWebView.frame.size.height;
    }
    else
    {
        return 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index=indexPath.row;
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        if(index==0)
        {
            //[webView loadHTMLString:html baseURL:[NSURL URLWithString:path]];
            [cell.contentView addSubview:myWebView];
        }
    }
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
