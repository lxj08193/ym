//
//  SortViewController.m
//  YunMei
//
//  Created by  macbook on 15-1-13.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "SortViewController.h"
#import "UIImageView+WebCache.h"

@interface SortViewController ()

@end

@implementation SortViewController
@synthesize tableViewList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"排行榜";
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
    
    return 3;
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
        switch (indexPath.row) {
            case 0:
                title=@"粉丝排行榜";
                image=@"exchange";
                break;
            case 1:
                title=@"金豆排行榜";
                image=@"exchange";
                break;
            case 2:
                title=@"购买排行榜";
                image=@"exchange";
                break;
                
            default:
                break;
        }
       
    
    }else if (indexPath.section==1){
        switch (indexPath.row) {
            case 0:
                title=@"广告点击量排行榜";
                image=@"exchange";
                break;
            case 1:
                title=@"产品销量排行榜";
                image=@"exchange";
                break;
            case 2:
                title=@"云币排行榜";
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

    SortFSViewController *viewController=nil;
    
    viewController=[[SortFSViewController alloc]initWithNibName:@"SortFSViewController" bundle:nil];
    
    if(indexPath.section==0){
        viewController.url=[NSString stringWithFormat:@"%@/client/act/comsumer/user/list",LocalHost];
        viewController.flag=1;
        switch (indexPath.row) {
            case 0:
                viewController.condition=@"fan";
                break;
            case 1:
                viewController.condition=@"source";
                break;
            case 2:
                viewController.condition=@"sale";
                break;
                
            default:
                break;
        }
    }else  if(indexPath.section==1){
        viewController.url=[NSString stringWithFormat:@"%@/client/act/comsumer/shop/list",LocalHost];
        switch (indexPath.row) {
            case 0:
                viewController.condition=@"advert";
                viewController.viewType=1;
                break;
            case 1:
                viewController.condition=@"sale";
                viewController.viewType=1;
                break;
            case 2:
                viewController.condition=@"gold";
                viewController.viewType=1;
                break;
                
            default:
                break;
        }
    }
    
    [viewController setTitle:[[tableView cellForRowAtIndexPath:indexPath] textLabel].text];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
