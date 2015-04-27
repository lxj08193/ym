//
//  AdAppViewController.m
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import "AdGGViewController.h"

@interface AdGGViewController ()

@end

@implementation AdGGViewController
@synthesize tableViewList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"广告管理";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return 1;
    }
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 4;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"cell1";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    NSString *title=@"";
    NSString *detailtitle=@"";
    NSString *image=@"";

    if(indexPath.section==0){
        switch (indexPath.row) {
            case 0:
                title=@"新增广告";
                image=@"exchange";
                detailtitle=@"5";
                break;
            case 1:
                title=@"待审核的广告";
                image=@"exchange";
                detailtitle=@"12";
                break;
            case 2:
                title=@"审核通过的广告";
                image=@"exchange";
                detailtitle=@"12";
                break;
            case 3:
                title=@"通过审核";
                image=@"exchange";
                detailtitle=@"12";
                break;
            default:
                break;
        }
        
        
    }else if (indexPath.section==1){
        switch (indexPath.row) {
            case 0:
                title=@"投放中的广告";
                image=@"exchange";
                detailtitle=@"5";
                break;
            case 1:
                title=@"已播完的广告";
                image=@"exchange";
                detailtitle=@"12";
                break;
                
            default:
                break;
        }
        
    }

    
    [cell.imageView setImage:[UIImage imageNamed:image]];
    [cell.textLabel setText:title];
    //[cell.detailTextLabel setText:detailtitle];
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    //[cell.detailTextLabel setFont:[UIFont systemFontOfSize:14]];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0&&indexPath.row==0){
        AdGGAddViewController *viewController=viewController=[[AdGGAddViewController alloc]initWithNibName:@"AdGGAddViewController" bundle:nil];
        [viewController setTitle:@"添加广告"];
        [self.navigationController pushViewController:viewController animated:YES];
        
        return;
    }
    
    int state=0;
    if(indexPath.section==0){
        switch (indexPath.row) {
            case 0:
                state=0;
                break;
            case 1:
                state=2;
                break;
            case 2:
                state=1;
                break;
                
            default:
                break;
        }
    }else if(indexPath.section==1){
        switch (indexPath.row) {
            case 0:
                state=3;
                break;
            case 1:
                state=4;
                break;
            default:
                break;
        }
    }

    
    AdGGListViewController *viewController=viewController=[[AdGGListViewController alloc]initWithNibName:@"AdGGListViewController" bundle:nil];
    viewController.state=state;
    
    [viewController setTitle:[[tableView cellForRowAtIndexPath:indexPath] textLabel].text];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
