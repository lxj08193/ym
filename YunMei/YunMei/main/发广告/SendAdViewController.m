//
//  SendAdViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-10.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "SendAdViewController.h"
#import "ShopRegisterViewController.h"

@interface SendAdViewController ()

@end

@implementation SendAdViewController
@synthesize imgHead,lblName,lblGold,lblAdNum,lblAdOverNum;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"发广告";
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

-(void)viewDidAppear:(BOOL)animated
{
    AppDelegate *delegate=[[UIApplication sharedApplication]delegate];
    if(delegate.userCode==1)
    {
        ShopRegisterViewController *controller=[[ShopRegisterViewController alloc]initWithNibName:@"ShopRegisterViewController" bundle:nil];
        
        
        [self.navigationController pushViewController:controller animated:NO];
        //[self.navigationController presentViewController:controller animated:YES completion:^{
            
        //}];
        
    }else{

        /*
        
        [YunMeiHttpUtils httpRequest:[NSString stringWithFormat:@"%@/client/act/comsumer/shop/getById",LocalHostm] withBlock:^(NSDictionary *dict) {
            [self GetShopInfo:[dict objectForKey:@"data"]];
        }];
         */
        NSString *url=[NSString stringWithFormat:@"%@/client/act/comsumer/shop/getById",LocalHostm];
        
        [self httpRequest:url pm:nil data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"user",@"tag", nil]];
    }
}
-(void)processHttpRequst:(NSDictionary *)dict userInfoMas:(NSDictionary *)userInfo{
    if(userInfo==nil){
        return;
    }
    if([[userInfo allKeys] containsObject:@"tag"]&&[[userInfo objectForKey:@"tag"] isEqualToString:@"user"]){
        [self GetShopInfo:[dict objectForKey:@"data"]];
        return;
    }
}
-(void)GetShopInfo:(NSDictionary *)data
{
//    advertNum = 100;
//    comfirmTime = 0;
//    comfirmUserId = 0;
//    createTime = 1422078089859;
//    editTime = 0;
//    extendCode = "";
//    extendTel = "";
//    goldFee = 0;
//    goldTotal = 0;
//    peopleId = 198;
//    peopleTel = 15925108352;
//    shopAddress = "ffjjgg\U4e00\U70b9";
//    shopArea = 440513;
//    shopCity = 440500;
//    shopId = 772;
//    shopIntroduce = chhjjjjbfd;
//    shopLogUrl = "/f3c4fa70-2506-42f4-b7e0-a1a55a49fd9c";
//    shopName = "\U738b";
//    shopPeople = "\U5360\U65e7";
//    shopProvince = 440000;
//    shopState = 0;
//    shopTel = 12345678901;
//    shopType = 0;
//    vipLevel = 0;
//    xyIP = "<null>";
//    xyShopId = 0;

    NSString *shopLogUrl=[data objectForKey:@"shopLogUrl"];
    
    NSString *imgUrl=[NSString stringWithFormat: @"%@/client/act/comsumer/getImg?url=%@",LocalHostm,shopLogUrl];
    [imgHead setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil options:SDWebImageRetryFailed];
    lblName.text = [data objectForKey:@"shopName"];
    lblGold.text = [[data objectForKey:@"goldTotal"]stringValue];
    lblAdNum.text = [[data objectForKey:@"advertNum"]stringValue];
    lblAdOverNum.text = [[data objectForKey:@"advertNum"]stringValue];
}

-(IBAction)shszAction:(id)sender{
    AdSetViewController *viewController=[[AdSetViewController alloc]initWithNibName:@"AdSetViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];

}
-(IBAction)xjyzAction:(id)sender{
    AdXJViewController *viewController=[[AdXJViewController alloc]initWithNibName:@"AdXJViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
-(IBAction)zztfAction:(id)sender{
    AdJZViewController *viewController=[[AdJZViewController alloc]initWithNibName:@"AdJZViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];

}
-(IBAction)ggglAction:(id)sender{
    AdGGViewController *viewController=[[AdGGViewController alloc]initWithNibName:@"AdGGViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];

}
-(IBAction)xsglAction:(id)sender{
    AdXSViewController *viewController=[[AdXSViewController alloc]initWithNibName:@"AdXSViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}
-(IBAction)spglAction:(id)sender{
    AdSPViewController *viewController=[[AdSPViewController alloc]initWithNibName:@"AdSPViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];

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
