//
//  YunMeiHttpUtils.h
//  YunMei
//
//  Created by zhengjiang on 15-1-7.
//  Copyright (c) 2015年 zhengjiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SVProgressHUD.h"

typedef void(^HttpSendBlock)(NSDictionary *dict);

@interface YunMeiHttpUtils : NSObject
/*不带参数网络访问
 实例:
 [YunMeiHttpUtils httpRequest:@"https://192.168.0.11:8443/sso/act/sso/user/isXy?peopleTel=15925108352" withBlock:^(NSDictionary *dict) {
 }];

 */
+(void)httpRequest:(NSString *)url  withBlock:(HttpSendBlock) block;

//带参数和文件网络访问
+(void)httpRequest:(NSString *)url pm:(NSMutableDictionary *)parameter  withBlock:(HttpSendBlock) block;

//
/*带参数和文件网络访问
 实例:
 
  NSMutableDictionary *md=[[NSMutableDictionary alloc]initWithCapacity:0];
 [YunMeiHttpUtils httpRequest:@"https://192.168.0.11:8443/sso/act/sso/user/isXy?peopleTel=15925108352" pm:md withBlock:^(NSDictionary *dict) {
   NSString *username=[dict objectForKey:@"username"];
   NSLog(@"回来了%@"，dict);
 }];
 
 */
+(void)httpRequest:(NSString *)url pm:(NSMutableDictionary *)parameter data:(NSArray *)fileData withBlock:(HttpSendBlock) block;

@end
