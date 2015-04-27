//
//  PersonalViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "PersonalViewController.h"

@interface PersonalViewController ()

@end

@implementation PersonalViewController
@synthesize userButton,imgUserHead,scrollView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"个人中心";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height);
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
//    appId = "<null>";
//    channelId = "<null>";
//    comfirmTime = 0;
//    comfirmUserId = 0;
//    createTime = 0;
//    deviceType = 0;
//    editTime = 0;
//    entenedCode = "<null>";
//    extenedTel = "<null>";
//    integralFee = 0;
//    integralFeeAll = 0;
//    loginName = 15925108352;
//    password = 202cb962ac59075b964b07152d234b70;
//    peopleId = 198;
//    peopleLogUrl = "<null>";
//    peopleName = "<null>";
//    peopleState = 0;
//    peopleTel = 15925108352;
//    peopleType = 0;
//    userId = "<null>";
//    vipLevel = 0;
//    xyCustomerId = 0;
//    xyIP = "<null>";
//    xyUserId = 0;

    [super viewWillAppear:animated];
    NSString *url=[NSString stringWithFormat:@"%@/client/act/comsumer/user/getById",LocalHost];
    
    [self httpRequest:url pm:nil data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"user",@"tag", nil]];
    
}
-(void)processHttpRequst:(NSDictionary *)dict userInfoMas:(NSDictionary *)userInfo{
    if(userInfo==nil){
        return;
    }
    if([[userInfo allKeys] containsObject:@"tag"]&&[[userInfo objectForKey:@"tag"] isEqualToString:@"user"]){
        NSDictionary *user=[dict objectForKey:@"data" ];
        
        NSString *userName = [NSString stringWithFormat:@"用户名：%@",[[dict objectForKey:@"data" ] objectForKey:@"loginName"]];
        
        [userButton setTitle:userName forState:UIControlStateNormal];
        
        
        if([[user allKeys]containsObject:@"peopleId"]){
            
           AppDelegate *app = [[UIApplication sharedApplication] delegate];
            app.peopleId=[[user objectForKey:@"peopleId"] integerValue];
        }
        
        
        if ([[[dict objectForKey:@"data" ] objectForKey:@"peopleLogUrl"] isEqual:[NSNull null]]) {
            // do something
        }else{
            NSString *imgUrl=[NSString stringWithFormat: @"%@/client/act/comsumer/getImg?url=%@",LocalHostm,[[dict objectForKey:@"data" ] objectForKey:@"peopleLogUrl"]];
            
            //[imgUserHead setImage:[self GetHeadImg:[dict objectForKey:@"peopleLogUrl"]]];
            [imgUserHead setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil options:SDWebImageRetryFailed];
        }
        
        
        
        return;
    }
}
-(IBAction)BookList:(id)sender
{
    BookListViewController *controller=[[BookListViewController alloc]initWithNibName:@"BookListViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
-(IBAction)setAction:(id)sende{
    CSetViewController *controller=[[CSetViewController alloc]initWithNibName:@"CSetViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];

}

-(IBAction)AddRess:(id)sender
{
    AddressViewController *controller=[[AddressViewController alloc]initWithNibName:@"AddressViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)About:(id)sender
{
    AboutViewController *controller=[[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}
-(IBAction)userAction:(id)sende{
    UserUpDataViewController *controller=[[UserUpDataViewController alloc]initWithNibName:@"UserUpDataViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];

}
-(IBAction)sourceAction:(id)sende{
    SourceViewController *controller=[[SourceViewController alloc]initWithNibName:@"SourceViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];


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
