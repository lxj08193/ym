//
//  AdAppViewController.m
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import "AdXJViewController.h"

@interface AdXJViewController ()

@end

@implementation AdXJViewController
@synthesize tableViewList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"星级验证";
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
                title=@"商家资质认证";
                image=@"exchange";
                detailtitle=@"5";
                break;
            case 1:
                title=@"商家购买VIP";
                image=@"exchange";
                detailtitle=@"12";
                break;
            default:
                break;
        }
        
        
    }else if (indexPath.section==1){
        switch (indexPath.row) {
            case 0:
                title=@"购买云币";
                image=@"exchange";
                detailtitle=@"5";
                break;
            case 1:
                title=@"购买记录";
                image=@"exchange";
                detailtitle=@"12";
                break;
                
            default:
                break;
        }
        
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
    
    if(indexPath.section==0){
        switch (indexPath.row) {
            case 0:
                viewController=[[AdXJZZRZViewController alloc]initWithNibName:@"AdXJZZRZViewController" bundle:nil];
                break;
            case 1:
                viewController=[[AdVipViewController alloc]initWithNibName:@"AdVipViewController" bundle:nil];
                break;
            default:
                break;
        }
    }else  if(indexPath.section==1){
        switch (indexPath.row) {
            case 0:
                viewController=[[AdYBViewController alloc]initWithNibName:@"AdYBViewController" bundle:nil];
                break;
            case 1:
                viewController=[[AdGMListViewController alloc]initWithNibName:@"AdGMListViewController" bundle:nil];
                break;
            default:
                break;
        }
    }
    
    [viewController setTitle:[[tableView cellForRowAtIndexPath:indexPath] textLabel].text];
    [self.navigationController pushViewController:viewController animated:YES];
     
}

@end
