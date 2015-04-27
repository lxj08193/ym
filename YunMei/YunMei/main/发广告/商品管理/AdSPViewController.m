//
//  AdAppViewController.m
//  YunMei
//
//  Created by XingJian Li on 15-1-24.
//  Copyright (c) 2015年 XingJian Li. All rights reserved.
//

#import "AdSPViewController.h"

@interface AdSPViewController ()

@end

@implementation AdSPViewController
@synthesize tableViewList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"商品管理";
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
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
            title=@"新增商品";
            image=@"exchange";
            detailtitle=@"5";
            break;
        case 1:
            title=@"待审核的商品";
            image=@"exchange";
            detailtitle=@"12";
            break;
        case 2:
            title=@"通过审核的商品";
            image=@"exchange";
            detailtitle=@"12";
            break;
        case 3:
            title=@"未通过审核的商品";
            image=@"exchange";
            detailtitle=@"12";
            break;
        default:
            break;
    }


    
    [cell.imageView setImage:[UIImage imageNamed:image]];
    [cell.textLabel setText:title];
    //[cell.detailTextLabel setText:detailtitle];
    
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    //[cell.detailTextLabel setFont:[UIFont systemFontOfSize:14]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        AdSPAddViewController *viewController=viewController=[[AdSPAddViewController alloc]initWithNibName:@"AdSPAddViewController" bundle:nil];
        [viewController setTitle:@"添加商品"];
        [self.navigationController pushViewController:viewController animated:YES];
    
        return;
    }
    
    int state=0;
    
    switch (indexPath.row) {
        case 0:
            state=0;
            break;
        case 1:
            state=0;
            break;
        case 2:
            state=1;
            break;
        case 3:
            state=2;
            break;
            
        default:
            break;
    }
    AdSPListViewController *viewController=viewController=[[AdSPListViewController alloc]initWithNibName:@"AdSPListViewController" bundle:nil];
    viewController.state=state;
    [viewController setTitle:[[tableView cellForRowAtIndexPath:indexPath] textLabel].text];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
