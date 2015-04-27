//
//  YunMeiHttpUtils.m
//  YunMei
//
//  Created by zhengjiang on 15-1-7.
//  Copyright (c) 2015年 zhengjiang. All rights reserved.
//

#import "YunMeiHttpUtils.h"
#import "Reachability.h"

@implementation YunMeiHttpUtils

ASIFormDataRequest *loadRequest;

//不带参数
+(void)httpRequest:(NSString *)url  withBlock:(HttpSendBlock) block{
    [self httpRequest:url pm:nil data:nil  withBlock:block];
}

//带参数
+(void)httpRequest:(NSString *)url pm:(NSMutableDictionary *)parameter  withBlock:(HttpSendBlock) block{
    [self httpRequest:url pm:parameter data:nil  withBlock:block];
}

//带参数和文件
+(void)httpRequest:(NSString *)url pm:(NSMutableDictionary *)parameter data:(NSArray *)fileData withBlock:(HttpSendBlock) block{
    
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
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    if(!app.cookie){
      [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:app.cookie];
    }
    
    //[loadRequest setDelegate:selfelegate];
    @try {
        
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
    
    [loadRequest setTimeOutSeconds:30.0];
    loadRequest.shouldAttemptPersistentConnection = NO;
    
    [loadRequest setAuthenticationScheme:@"https"];//设置验证方式
    [loadRequest setValidatesSecureCertificate:NO];//设置验证证书
    
    [loadRequest setStartedBlock:^{
           // [SVProgressHUD show];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES; //显示
        }];
    
    [loadRequest setCompletionBlock:^{
        NSError *error = [loadRequest error ];
        //assert (!error);
        // 如果请求成功，返回 Response
        NSString *response = [loadRequest responseString ];
        if (!error) {
            NSLog(@"请求成功:返回%@",response);
            NSData* data = [response dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *testDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            block(testDict);
            
            //保存
            //AppDelegate *app = [[UIApplication sharedApplication] delegate];
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (NSHTTPCookie *httpcookie in [cookieJar cookies]) {
                app.cookie = httpcookie;
                //NSLog(@"cookie%@",app.cookie);
            }
            
        }else{
            NSLog(@"报错了: %@", error);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SVProgressHUD showErrorWithStatus:@"请求失败，请重试"];
        }
        }];
        
    [loadRequest setFailedBlock:^{
        // 请求响应失败，返回错误信息
        NSError *error = [loadRequest error ];
        NSLog ( @"响应失败:%@" ,[error userInfo ]);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD showErrorWithStatus:@"请求超时，请重试"];
        
        }];
    
    // 开始同步请求
    [loadRequest startSynchronous ];
    }
    @catch (NSException *exception) {
        NSLog(@"报错了: %@", exception);
    }
    @finally {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [SVProgressHUD dismiss];
        [loadRequest clearDelegatesAndCancel];
        [loadRequest cancel];
        loadRequest=nil;
    }

    
}



@end
