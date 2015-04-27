//
//  SortViewController.m
//  YunMei
//
//  Created by  macbook on 15-1-13.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "CSetViewController.h"
#import "UIImageView+WebCache.h"

@interface CSetViewController ()

@end

@implementation CSetViewController
@synthesize tableViewList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"通用设置";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    if (section==0) {
        return 10;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        return 3;
    }
    return 5;
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
    NSString *image=@"";
    
    if(indexPath.section==0){
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if (indexPath.row==0) {
            title=@"缓存大小 0M";
            image=@"exchange";
            UIButton *clearButton=[[UIButton alloc]initWithFrame:CGRectMake(54.0f, 16.0f, 100.0f, 28.0f)];
            [clearButton setTitle:@"清理缓存" forState:UIControlStateNormal];
            [clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            cell.accessoryView=clearButton;
        }else if (indexPath.row==1) {
            title=@"自动清理";
            image=@"exchange";
            UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(54.0f, 16.0f, 100.0f, 28.0f)];
            switchView.on = YES;//设置初始为ON的一边
            //[switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView=switchView;

            
        }else if (indexPath.row==2) {
            title=@"声音开关";
            image=@"exchange";
            UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectMake(54.0f, 16.0f, 100.0f, 28.0f)];
            switchView.on = YES;//设置初始为ON的一边
            //[switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            cell.accessoryView=switchView;
            
        }
       
    
    }else if (indexPath.section==1){
        switch (indexPath.row) {
            case 0:
                title=@"广告查看设置";
                image=@"exchange";
                break;
            case 1:
                title=@"收货地址管理";
                image=@"exchange";
                break;
            case 2:
                title=@"手机验证";
                image=@"exchange";
                break;
            case 3:
                title=@"实名验证";
                image=@"exchange";
                break;
            case 4:
                title=@"修改密码";
                image=@"exchange";
                break;
                
            default:
                break;
        }
    
    }
    [cell.imageView setImage:[UIImage imageNamed:image]];
    [cell.textLabel setText:title];
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIViewController *viewController;
    
    if(indexPath.section==1){
        switch (indexPath.row) {
            case 0:
                viewController=[[AdGGViewController alloc]initWithNibName:@"AdGGViewController" bundle:nil];
                
                break;
            case 1:
                viewController=[[AddressViewController alloc]initWithNibName:@"AddressViewController" bundle:nil];
                break;
            case 2:
                viewController=[[SFRZViewController alloc]initWithNibName:@"SJYZViewController" bundle:nil];
                break;
            case 3:
                viewController=[[SFRZViewController alloc]initWithNibName:@"SFRZViewController" bundle:nil];
                
                break;
            case 4:
                viewController=[[ResetPasswordViewController alloc]initWithNibName:@"ResetPasswordViewController" bundle:nil];
                
                break;
                
            default:
                break;
        }
    }
    
    [viewController setTitle:[[tableView cellForRowAtIndexPath:indexPath] textLabel].text];
    [self.navigationController pushViewController:viewController animated:YES];
    
}

@end
