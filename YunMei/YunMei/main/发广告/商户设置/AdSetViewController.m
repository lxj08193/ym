//
//  AdAppViewController.m
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import "AdSetViewController.h"

@interface AdSetViewController ()

@end

@implementation AdSetViewController
@synthesize tableViewList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"商户设置";
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
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
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
    
    switch (indexPath.row) {
        case 0:
            title=@"兑换管理员通知";
            image=@"exchange";
            detailtitle=@"5";
            break;
        case 1:
            title=@"公告";
            image=@"exchange";
            detailtitle=@"12";
            break;
        case 2:
            title=@"意见反馈";
            image=@"exchange";
            detailtitle=@"1";
            break;
        case 3:
            title=@"消息中心";
            image=@"exchange";
            detailtitle=@"4";
            break;
        case 4:
            title=@"常见问题";
            image=@"exchange";
            detailtitle=@"23";
            break;
        case 5:
            title=@"关于我们";
            image=@"exchange";
            break;
            
        default:
            break;
    }

    
    [cell.imageView setImage:[UIImage imageNamed:image]];
    [cell.textLabel setText:title];
    [cell.detailTextLabel setText:detailtitle];
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14]];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *viewController=nil;
    
    switch (indexPath.row) {
        case 0:
            viewController=[[AdSetGLYGGListViewController alloc]initWithNibName:@"AdSetGLYGGListViewController" bundle:nil];
            break;
        case 1:
            viewController=[[AdSetGGListViewController alloc]initWithNibName:@"AdSetGGListViewController" bundle:nil];
            break;
        case 2:
            viewController=[[AdSetFKViewController alloc]initWithNibName:@"AdSetFKViewController" bundle:nil];
            break;
        case 3:
            viewController=[[AdSetXXListViewController alloc]initWithNibName:@"AdSetXXListViewController" bundle:nil];
            break;
        case 4:
            viewController=[[AdSetWTListViewController alloc]initWithNibName:@"AdSetWTListViewController" bundle:nil];
            break;
            
        default:
            break;
    }
    if(nil!=viewController){
          [viewController setTitle:[[tableView cellForRowAtIndexPath:indexPath] textLabel].text];
         [self.navigationController pushViewController:viewController animated:YES];
        return;
    }
    if(indexPath.row==5){
        [self showDetailView:@"http://www.163.com" thetitle:@"关于我们"];
    }
     
}

@end
