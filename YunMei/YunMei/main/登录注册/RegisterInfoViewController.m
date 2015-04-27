//
//  RegisterInfoViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-12.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "RegisterInfoViewController.h"
#import "MyMD5.h"

@interface RegisterInfoViewController ()

@end

@implementation RegisterInfoViewController
@synthesize txtPhone,txtPwd,txtRePwd,phone,flag,scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"注册"];
    [self.navigationItem setHidesBackButton:YES];
    txtPhone.text=phone;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)UITextField_Edit:(id)sender
{
    [scrollView setContentOffset:CGPointMake(0, 150) animated:YES];
    
}

-(IBAction)UITextField_Edit_End:(id)sender
{
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}


-(IBAction)Register:(id)sender
{
    if(txtPwd.text.length==0)
    {
        [self showtips:@"请输入密码"];
        return;
    }
    if(txtRePwd.text.length==0)
    {
        [self showtips:@"请再次输入密码"];
        return;
    }
    if(![txtPwd.text isEqualToString:txtRePwd.text])
    {
        [self showtips:@"两次输入的密码必须一致"];
        return;
    }
    
    NSMutableDictionary *md=[[NSMutableDictionary alloc]initWithCapacity:0];
    [md setObject:txtPhone.text forKey:@"peopleTel"];
    [md setObject:[MyMD5 md5: txtPwd.text] forKey:@"password"];
    [md setObject:flag forKey:@"flag"];
    
    NSString *url=[NSString stringWithFormat:@"%@/sso/act/sso/user/register",LocalHost];
    
    [YunMeiHttpUtils httpRequest:url pm:md withBlock:^(NSDictionary *dict) {
        NSInteger type=[[dict objectForKey:@"type"]integerValue];
        if(type==1)
        {
            IndexViewController *controller=[[IndexViewController alloc]initWithNibName:@"IndexViewController" bundle:nil];
            [self Login:txtPhone.text withPwd:txtPwd.text withController:controller];
        }
        else
        {
            [self showtips:[dict objectForKey:@"message"]];
        }
    }];

    
    
    
//    IndexViewController *controller=[[IndexViewController alloc]initWithNibName:@"" bundle:nil];
//    [self.navigationController pushViewController:controller animated:YES];
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
