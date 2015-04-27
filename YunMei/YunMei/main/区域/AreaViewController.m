//
//  AreaViewController.m
//  YunMei
//
//  Created by  macbook on 15-1-27.
//  Copyright (c) 2015年  macbook. All rights reserved.
//

#import "AreaViewController.h"

@interface AreaViewController ()
{
    int level;//级别，1为省，2为地市，3为区县
    NSArray *datas;
    NSMutableArray *area;
}

@end

@implementation AreaViewController
@synthesize myTableView,delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"区域"];
    area = [[NSMutableArray alloc]initWithCapacity:0];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    level=0;
    NSString *url=[NSString stringWithFormat:@"%@/client/act/area/getProvince",LocalHost];
    [YunMeiHttpUtils httpRequest:url withBlock:^(NSDictionary *dict) {
        [self GetAreaFinish:[dict objectForKey:@"data"]];
    }];
}

-(void)GetAreaFinish:(NSArray *)data
{
    datas=data;
    [myTableView reloadData];
    if(level<3)
    {
        level++;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    id obj=[datas objectAtIndex:indexPath.row];
    cell.textLabel.text=[obj objectForKey:@"areaName"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id obj=[datas objectAtIndex:indexPath.row];
    [area addObject:obj];
    NSString *url;
    if(level==1)
    {
        url=@"%@/client/act/area/getCity?provinceId=%@";
    }
    else if(level ==2)
    {
        url=@"%@/client/act/area/getCounty?cityId=%@";
    }
    else
    {
        [delegate ReturnArea:area];
        [super BackUp:self];
        return;
    }
    url=[NSString stringWithFormat:url,LocalHost,[obj objectForKey:@"areaId"]];
    [YunMeiHttpUtils httpRequest:url withBlock:^(NSDictionary *dict) {
        [self GetAreaFinish:[dict objectForKey:@"data"]];
    }];
}

-(void)BackUp:(id)sender
{
    [super BackUp:sender];
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
