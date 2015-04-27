//
//  LoginViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-12.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "LoginViewController.h"
#import "IndexViewController.h"
#import "MyMD5.h"
#import "RDVTabBarController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize txtPhone,txtPwd,scrollView,checkBox;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setTitle:@"登录"];
    [checkBox setImage:[UIImage imageNamed:@"icon_check_alt2.png"] forState:UIControlStateSelected];
    
    //判断是否是记住密码
    NSDictionary *userInfo=[self getMeberInfo];
    if(nil!=userInfo&&[[userInfo allKeys] containsObject:@"username"]&&[[userInfo allKeys] containsObject:@"password"]){
        txtPhone.text=[userInfo objectForKey:@"username"];
        txtPwd.text=[userInfo objectForKey:@"password"];
        
        [checkBox setSelected:YES];
    }
    //self.navigationItem.leftBarButtonItem=nil;
    
    
    //[self.navigationController.navigationBar setHidden:FALSE];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //[super viewWillAppear:animated];
    /*
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:COLOR_NAVIGATIONBAR_BACK_IMAGE style:UIBarButtonItemStyleBordered target:self action:@selector(backAction:)];
    backItem.tintColor=COLOR_NAVIGATIONBAR_BACK_COLOR;
    
    //backItem.imageInsets=COLOR_NAVIGATIONBAR_BACK_imageInsets;
    self.navigationItem.leftBarButtonItem=backItem;
    */
    
    [self.navigationItem setHidesBackButton:YES];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

//读取账号密码
-(NSDictionary *)getMeberInfo{
    //NSDictionary *userInfo=[NSDictionary dictionaryWithContentsOfFile:UserConfig_List_path];
    NSDictionary *userInfo=[self readPlist:UserConfig_List_path_name];
    return userInfo;
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
    [super viewWillDisappear:animated];
}

-(IBAction)CheckBoxThuch:(id)sender
{
    if(checkBox.selected)
    {
        [checkBox setSelected:NO];    }
    else
    {
        [checkBox setSelected:YES];    }

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
    RegisterViewController *controller=[[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}



-(IBAction)LoginTuch:(id)sender
{
   
    if(txtPhone.text.length==0)
    {
        [self showtips:@"请输入您的手机号"];
        return ;
    }
    if(txtPwd.text.length==0)
    {
        [self showtips:@"请输入您的密码"];
        return ;
    }
    
    NSString *url=[NSString stringWithFormat:@"%@/sso/act/sso/user/login",LocalHost];
    NSMutableDictionary *md=[[NSMutableDictionary alloc]initWithCapacity:0];
    [md setObject:txtPhone.text forKey:@"loginName"];
    [md setObject:[MyMD5 md5:txtPwd.text] forKey:@"password"];
    //[self httpRequest:url pm:md];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [self httpRequest:url pm:md data:nil userInfoMas:[NSDictionary dictionaryWithObjectsAndKeys:@"tag",@"login", nil]];

 

}
-(void)processHttpRequst:(NSDictionary *)dict userInfoMas:(NSDictionary *)userInfo{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
    NSInteger type=[[dict objectForKey:@"type"]integerValue];
    if (type==1)
    {
        AppDelegate *delegate=[[UIApplication sharedApplication]delegate];
        delegate.userCode =[[dict objectForKey:@"code"]integerValue];
        
        if(checkBox.selected)
        {
            //-----保存用户和密码-------
            NSMutableDictionary *userInfo=[[NSMutableDictionary alloc]init];
            [userInfo setObject:txtPhone.text forKey:@"username"];
            [userInfo setObject:txtPwd.text forKey:@"password"];
            [self writePlist:userInfo thePath:UserConfig_List_path_name];
            //-----保存用户和密码---end----
        }
        else
        {
            
            
        }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self showtips:[dict objectForKey:@"message" ]];
    }


}



@end
