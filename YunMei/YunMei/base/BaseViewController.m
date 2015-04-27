//
//  BaseViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "BaseViewController.h"
#import "MyMD5.h"
#import "LoginViewController.h"
#import "MyDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface BaseViewController ()
{
    NSDictionary *dic;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)BackUp:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
   
}

-(void)viewWillAppear:(BOOL)animated{
    //[self.navigationController.navigationBar setHidden:TRUE];
    
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if(nil==app.cookie && self.title!=@"注册"){
        LoginViewController *loginViewController=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    
}

//将数据写入plist
-(void) writePlist:(NSDictionary*) data  thePath:(NSString *)filepath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filepath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath: path]){//如果文件存在，写入数据
        //写入文件
        if(![data writeToFile:path atomically:YES]){
            // [SVProgressHUD showErrorWithStatus:@"同步数据失败"];
            NSLog(@"同步数据失败");
        }
    }else {
        NSString *appFile = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: filepath] ];
        //创建字典
        NSMutableDictionary *dictplist = [[NSMutableDictionary alloc ] init];
        ///写入文件
        if(![dictplist writeToFile:appFile atomically:YES]){
            // [SVProgressHUD showErrorWithStatus:@"同步数据失败"];
            NSLog(@"同步数据失败");
        }
        
        if(![data writeToFile:path atomically:YES]){
            //[SVProgressHUD showErrorWithStatus:@"同步数据失败"];
            NSLog(@"同步数据失败");
        }
    }
    
}


-(NSDictionary *)readPlist:(NSString *)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile: path];
    
    
    if ([fileManager fileExistsAtPath: path]){//如果文件存在，写入数据
        data = [[NSDictionary alloc] initWithContentsOfFile: path];
    }else{
        // If the file doesn’t exist, create an empty dictionary
        data = [[NSDictionary alloc] init];
    }
    return data;
}


-(IBAction)TextField_DidEndOnExit:(id)sender
{
    [sender resignFirstResponder];
}
-(void)pushViewController:(UIViewController *)controller{


}
-(void)showDetailView:(NSString *)url  thetitle:(NSString *)title{
    MyDetailViewController *detail=[[MyDetailViewController alloc]initWithNibName:@"MyDetailViewController" bundle:nil];
    detail.url=url;
    detail.title=title;
    [self.navigationController pushViewController:detail animated:YES];
}

-(UIImage *)GetHeadImg:(NSString *)headUrl
{
    NSString *url=[NSString stringWithFormat: @"%@/client/act/comsumer/getImg?url=%@",LocalHostm,headUrl];
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    UIImageView *img =[[UIImageView alloc]init];
    [img setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil options:SDWebImageRetryFailed];
    return img.image;
}

-(void)showtips:(NSString *)tipMsg
{
    [SVProgressHUD showInfoWithStatus:tipMsg];
    /*
    UIAlertView *aShow = [[UIAlertView alloc]initWithTitle:nil message:tipMsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [aShow show];
     */
}
/*
-(NSDictionary *)Login:(NSString *) phone withPwd: (NSString *)pwd withController:(BaseViewController *)controller
{
    if(phone.length==0)
    {
        [self showtips:@"请输入您的手机号"];
        return nil;
    }
    if(pwd.length==0)
    {
        [self showtips:@"请输入您的密码"];
        return nil;
    }
    NSString *url=[NSString stringWithFormat:@"%@/sso/act/sso/user/login",LocalHost];
    NSMutableDictionary *md=[[NSMutableDictionary alloc]initWithCapacity:0];
    [md setObject:phone forKey:@"loginName"];
    [md setObject:[MyMD5 md5:pwd] forKey:@"password"];
    
    [YunMeiHttpUtils httpRequest:url pm:md withBlock:^(NSDictionary *dict) {
        NSInteger type=[[dict objectForKey:@"type"]integerValue];
        if(controller!=nil)
        {
            if (type==1)
            {
                [self.navigationController pushViewController:controller animated:YES];
            }
            else
            {
                [self showtips:[dict objectForKey:@"message" ]];
            }

        }
        [self LoginFinsh:dict];
    }];
    return dic;
}

-(void)LoginFinsh:(NSDictionary *)dict
{
    dic=dict;
}
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//------------------------------网络访问处理-------------------------------------------
-(void)httpRequest:(NSString *)url{
    [self httpRequest:url pm:nil];

}
//带参数和文件网络访问
-(void)httpRequest:(NSString *)url pm:(NSMutableDictionary *)parameter{
 [self httpRequest:url pm:parameter data:nil userInfoMas:nil];

}
//带参数和文件
-(void)httpRequest:(NSString *)url pm:(NSMutableDictionary *)parameter data:(NSArray *)fileData userInfoMas:(NSDictionary *)userInfo{
    
    //没有网络
    if (![Reachability networkAvailable]) {
        [SVProgressHUD showInfoWithStatus:@"网络不可用"];
        return;
    }
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *urlstr = [NSURL URLWithString:url];
    
    //loadRequest = [ASIFormDataRequest requestWithURL:urlstr];
    loadRequest = [ASIFormDataRequest requestWithURL:urlstr];
    [loadRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [loadRequest setTimeOutSeconds:30.0];
    loadRequest.shouldAttemptPersistentConnection = NO;
    
    [loadRequest setAuthenticationScheme:@"https"];//设置验证方式
    [loadRequest setValidatesSecureCertificate:NO];//设置验证证书
    
    [loadRequest setDelegate:self];
    [loadRequest setDidFailSelector:@selector(requestDidFailed:)];
    [loadRequest setDidFinishSelector:@selector(requestDidSuccess:)];
    
    [loadRequest setUseCookiePersistence:YES];
    
    //用户自定义标识
    if(nil!=userInfo){
        [loadRequest setUserInfo:userInfo];
    }
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if(!app.cookie){
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:app.cookie];
    }
    
    //参数解析
    if(nil!=parameter){
        NSArray *arrayKes=[parameter allKeys];
        if ([arrayKes count]>0) {
            for(NSString *key in arrayKes){
                [loadRequest addPostValue:[parameter objectForKey:key] forKey:key];
            }
        }
    }
    
    //加入数据流
    if(fileData!=nil)
    {
        for(id item in fileData)
        {
            [loadRequest addData:[item objectForKey:@"data"] withFileName:[item objectForKey:@"fileName"] andContentType:[item objectForKey:@"type"] forKey:[item objectForKey:@"name"]];
        }
    }

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD showWithStatus:@"正在加载"];
    //开始执行
   [loadRequest startAsynchronous];
   
    
}

//执行成功
- (void)requestDidSuccess:(ASIFormDataRequest *)request
{
    //获取头文件
    NSDictionary *headers = [request responseHeaders];
    
    //获取http协议执行代码
    NSLog(@"Code:%d",[request responseStatusCode]);
   
    //关闭网络
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSError *error = [loadRequest error ];
    //assert (!error);
    // 如果请求成功，返回 Response
    NSString *response = [loadRequest responseString ];
    if (!error) {
        NSLog(@"请求成功:返回%@",response);
        NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
        
        //保存
        AppDelegate *app = [[UIApplication sharedApplication] delegate];
        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie *httpcookie in [cookieJar cookies]) {
            app.cookie = httpcookie;
            //NSLog(@"cookie%@",app.cookie);
        }
        [SVProgressHUD dismiss];
        [self processHttpRequst:dict userInfoMas:request.userInfo];
        
        //[request clearDelegatesAndCancel];
    }else{
        NSLog(@"报错了: %@", error);
        [SVProgressHUD showErrorWithStatus:@"请求失败，请重试"];
    }
    
    [request clearDelegatesAndCancel];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
}
////执行成功处理数据

-(void)processHttpRequst:(NSDictionary *)dict userInfoMas:(NSDictionary *)userInfo{
    NSLog(@"没有实现网络处理方法");


}

//执行失败
- (void)requestDidFailed:(ASIFormDataRequest *)request{
    //获取的用户自定义内容
   // NSString *method = [request.userInfo objectForKey:@"Method"];
    //获取错误数据
    NSError *error = [request error];
    NSLog(@"Error:%@",error);
    
    // 请求响应失败，返回错误信息
    NSLog ( @"响应失败:%@" ,[error userInfo ]);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [SVProgressHUD showErrorWithStatus:@"请求超时，请重试"];
    [request clearDelegatesAndCancel];
    //[SVProgressHUD dismiss];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}
//------------------------------网络访问处理-------------------------------------------


#pragma mark -
#pragma mark UITextFieldDelegate
//开始编辑：
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

//点击return按钮所做的动作：
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];//取消第一响应
    return YES;
}

//编辑完成：
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}


@end
