//
//  SourceViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-11.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "SourceViewController.h"

@interface SourceViewController ()

@end

@implementation SourceViewController

@synthesize tableViewList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我的金库";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableViewList=[[UITableView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:tableViewList];
    [tableViewList setDataSource:self];
    [tableViewList setDelegate:self];
    //-------隐藏UITableView多余的分割线(使用原因是没有数据时ios还会显示分割线)
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableViewList setTableFooterView:view];
    //--------隐藏UITableView多余的分割线
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
    
        return 3;
    }else if(section==1){
        return 6;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"cell1";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID1];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    NSString *title=@"";
    
    
    if(indexPath.section==0){
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    
        switch (indexPath.row) {
            case 0:
                title=@"会员等级";
                [cell setAccessoryView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1-2银库_03.png"]]];
                break;
            case 1:
                title=@"累计金豆     1000";
                break;
            case 2:
                title=@"可用金豆     5000";
                break;

            default:
                break;
        }
        
        
    }else if (indexPath.section==1){
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        switch (indexPath.row) {
            case 0:
                title=@"成为VIP";
                break;
            case 1:
                title=@"粉丝帮我赚的金豆";
                break;
            case 2:
                title=@"看广告的金豆";
                break;
            case 3:
                title=@"获得的金豆";
                break;
            case 4:
                title=@"花费的金豆";
                
                break;
            case 5:
                title=@"金豆充值";
                
                break;
            default:
                break;
        }
        
    }else if (indexPath.section==2){
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        title=@"金豆说明";
        [cell.detailTextLabel setText:@"说明:"];
    }

    [cell.textLabel setText:title];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==2) {
        return 100;
    }
    return 44;
}

@end
