//
//  RegisterViewController.m
//  PublicSystem
//
//  Created by  macbook on 14-12-12.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
{
    NSString *signString;
    NSURLConnection* getVerifyStateConn;
    NSMutableData* mData;
}
@end

@implementation RegisterViewController
@synthesize txtPhone,scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"注册"];
    [self.navigationItem setHidesBackButton:YES];
    self.ucs=[[UCSVerifyService alloc]initWithDelegate:self];
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


- (IBAction)GetVerifyCode:(id)sender
{
    [self.txtPhone resignFirstResponder];
    if (self.txtPhone.text.length!=11) {
        [self showtips:@"请输入合法的手机号码"];
        return;
    }
    
    
    //这个http请求就是为了获取sign，如果有sign就不用这个请求，直接调用[self requestCode];
    NSString *getStateStr = [NSString stringWithFormat:@"%@phone=%@",GetValiateStateBaseUrl,self.txtPhone.text];
    NSMutableURLRequest *getVerifyRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:getStateStr] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    getVerifyStateConn = [[NSURLConnection alloc] initWithRequest:getVerifyRequest delegate:self];
    [getVerifyStateConn start];
}

//点击“下一步” 验证
- (IBAction)bt_Verfy:(id)sender {
    [self.txtPhone resignFirstResponder];
    [self.txt_code resignFirstResponder];
    
    if(txtPhone.text.length==0)
    {
        [self showtips:@"请输入电话号码"];
        return;
    }
    
    __block NSMutableDictionary *dic;
    NSString *url =[NSString stringWithFormat:@"%@/sso/act/sso/user/isXy?peopleTel=%@",LocalHost,txtPhone.text];
    [YunMeiHttpUtils httpRequest:[NSString stringWithFormat:@"%@/sso/act/sso/user/isXy?peopleTel=%@",LocalHost,txtPhone.text] withBlock:^(NSDictionary *dic) {
        
        NSInteger type=[[dic objectForKey:@"type"] integerValue];
        
        RegisterInfoViewController *controller=[[RegisterInfoViewController alloc]initWithNibName:@"RegisterInfoViewController" bundle:nil];
        controller.phone=txtPhone.text;
        switch (type) {
            case 0:
                [self showtips:[dic objectForKey:@"message"]];
                break;
            case 1:
                controller.flag=@"true";
                [self.navigationController pushViewController:controller animated:YES];
                
                break;
            case 2:
                controller.flag=@"false";
                [self.navigationController pushViewController:controller animated:YES];
                break;
            default:
                break;
        }
    }];
//    if (self.txt_code.text.length==0) {
//        [self showtips:@"请输入验证码"];
//        return;
//    }
    
//    [self.ucs doVerificationCode:@"4c1990a5c1ad2674bc94bc39a6fd0699" withAppid:@"efb7e1de9da649fa83881afea2841cd7" withPhone:self.txtPhone.text withVerifycode:self.txt_code.text];
    
}

//获取验证码成功回调
-(void)onGetValiateCodeSuccessful:(NSInteger)nResult
{
    if (nResult==0) {
        [self showtips:@"已注册"];
        return;
    }
    
    
    if (nResult==1) {
        [self showtips:@"已下发短信验证码"];
    }
    if (nResult==2) {
        [self showtips:@"已下发语音验证码"];
    }
}

// 云验证成功
-(void)onDoValiateCodeSuccessful:(NSInteger)nResult
{
    if (nResult==0) {
        [self showtips:@"验证成功"];
//        [self.navigationController popViewControllerAnimated:NO];
        RegisterInfoViewController *controller=[[RegisterInfoViewController alloc]initWithNibName:@"RegisterInfoViewController" bundle:nil];
        controller.txtPhone.text=txtPhone.text;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
// 云验证失败
- (void) onDoValiateCodeFailed:(NSInteger)reason
{
    NSString *tipString;
    switch (reason) {
        case 401051:
            tipString = @"获取验证码失败";
            break;
        case 401052:
            tipString = @"验证码错误";
            break;
        case 401053:
            tipString = @"验证超时";
            break;
        case 401061:
            tipString = @"开发者账号无效";
            break;
        case 401062:
            tipString = @"验证码错误";
            break;
        case 401063:
            tipString = @"验证码过期";
            break;
        case 401064:
            tipString = @"30s内重复请求";
            break;
        case 401065:
            tipString = @"签名错误";
            break;
        case 401066:
            tipString = @"手机号码无效";
            break;
        case 401067:
            tipString = @"已经注册过";
            break;
            
        default:
            tipString = @"其他错误";
            break;
    }
    
    [self showtips:tipString];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    int code = [rsp statusCode];
    if (code != 200)
    {
        
        [connection cancel];
        connection = nil;
    }
    else
    {
        if (mData != nil)
        {
            mData = nil;
        }
        mData = [[NSMutableData alloc] init];
    }
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    connection = nil;
    
    [self showtips:[NSString stringWithFormat:@"%d",[error code]]];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSMutableString *connectString;
    
    connectString = [[NSMutableString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
    NSRange resultRange = [connectString rangeOfString:@"\"result\":"];
    NSString *resultMidString = [connectString substringFromIndex:resultRange.location+resultRange.length ];
    NSRange resultTailRange = [resultMidString rangeOfString:@","];
    NSString *resultString =[resultMidString substringToIndex:resultTailRange.location];
    if ([resultString isEqualToString:@"0"]) {
        
        NSRange signRange = [connectString rangeOfString:@"\"sign\":\""];
        NSString *signMidString = [connectString substringFromIndex:signRange.location+signRange.length ];
        NSRange signTailRange = [signMidString rangeOfString:@"\""];
        
        signString =[signMidString substringToIndex:signTailRange.location];
        [self requestCode:signString];
        
    }
    
    connection = nil;
    
}

//获取验证码
-(void)requestCode:(NSString *)key
{
    
//    [self.ucs getVerificationCode:@"e875314061874e898bab0624a8940c08" withAppid:@"ed91d225fd784910b3125e12cdf1cebb" withAppName:@"yunmei" withCodetype:1 withPhone:txtPhone.text withSeconds:60 withBusiness:1 withSign:signString];

    @try {
        
    
    [self.ucs getVerificationCode:@"4c1990a5c1ad2674bc94bc39a6fd0699" withAppid:@"efb7e1de9da649fa83881afea2841cd7" withAppName:@"测试DEMO" withCodetype:1 withPhone:txtPhone.text withSeconds:1 withBusiness:2 withSign:key];
    }
    @catch(NSException *e)
    {
        
    }
}

// 云获取验证码失败
- (void) onGetValiateCodeFailed:(NSInteger)reason
{
    NSString *tipString;
    switch (reason) {
        case 401051:
            tipString = @"获取验证码失败";
            break;
        case 401052:
            tipString = @"验证码错误";
            break;
        case 401053:
            tipString = @"验证超时";
            break;
        case 401061:
            tipString = @"开发者账号无效";
            break;
        case 401062:
            tipString = @"验证码错误";
            break;
        case 401063:
            tipString = @"验证码过期";
            break;
        case 401064:
            tipString = @"30s内重复请求";
            break;
        case 401065:
            tipString = @"签名错误";
            break;
        case 401066:
            tipString = @"手机号码无效";
            break;
        case 401067:
            tipString = @"已经注册过";
            break;
        default:
            tipString = @"其他错误";
            break;
    }
    
    [self showtips:tipString];
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
