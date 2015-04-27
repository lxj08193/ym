//
//  BaseViewController.h
//  PublicSystem
//
//  Created by  macbook on 14-12-9.
//  Copyright (c) 2014年 云南学锋物联网信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCSVerifyEvent.h"
#import "UCSVerifyService.h"
#import "UIImageView+WebCache.h"
//#import "ASIFormDataRequest.h"


#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SVProgressHUD.h"

#import "RDVTabBarController.h"

@interface BaseViewController : UIViewController<UITextFieldDelegate>{

    ASIFormDataRequest *loadRequest;
}

-(IBAction)BackUp:(id)sender;
-(void)showtips:(NSString *)tipMsg;
-(NSDictionary *)Login:(NSString *) phone withPwd: (NSString *)pwd withController:(BaseViewController *)controller;

-(void)showDetailView:(NSString *)url  thetitle:(NSString *)title;
-(UIImage *)GetHeadImg:(NSString *)headUrl;
-(void) writePlist:(NSDictionary*) data  thePath:(NSString *)filepath;
-(NSDictionary *)readPlist:(NSString *)fileName;


-(void)httpRequest:(NSString *)url;
//带参数和文件网络访问
-(void)httpRequest:(NSString *)url pm:(NSMutableDictionary *)parameter;
-(void)httpRequest:(NSString *)url pm:(NSMutableDictionary *)parameter data:(NSArray *)fileData userInfoMas:(NSDictionary *)userInfo;
-(void)processHttpRequst:(NSDictionary *)dict userInfoMas:(NSDictionary *)userInfo;
@end
