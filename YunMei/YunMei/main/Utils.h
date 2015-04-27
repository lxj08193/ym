//
//  Utils.h
//  NingboFirstHospital
//
//  Created by Tianwei on 14-4-3.
//  Copyright (c) 2014年 jhcm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "User.h"
//#import "News.h"

@interface Utils : NSObject

//#define API_URL                                 @"http://42.96.186.167/apps/zscc/api"
//#define IMAGE_URL                               @"http://42.96.186.167/apps/zscc/uploads/"
//#define HTML_IMAGE_URL                          @"http://42.96.186.167/apps/zscc/"

//#define API_URL                                 @"http://115.29.45.40/apps/zscc/api"
//#define IMAGE_URL                               @"http://115.29.45.40/apps/zscc/uploads/"
//#define HTML_IMAGE_URL                          @"http://115.29.45.40/apps/zscc/"

//220.163.43.252:333测试
//192.168.3.107
#define API_URL                                 @"http://220.163.43.252:333/zscc/apps/zscc/api_android"
#define IMAGE_URL                               @"http://220.163.43.252:333/zscc/apps/zscc/uploads/"
#define HTML_IMAGE_URL                          @"http://220.163.43.252:333/zscc/apps/zscc/"

#define  common_user_id  @"401"
#define  common_user_name @"游客"

//百度天气预报接口
#define weather_data_API　@"http://api.map.baidu.com/telematics/v3/weather?location=昆明&output=json&ak=3uCGSXMmMLnj9maYxoIEu5xb"


#define UMENG_APPKEY @"53a9355f56240b245c00e39d"

#define COLOR_MAIN_TEXT                         [Utils colorWithHexString:@"#333333"]
#define COLOR_SUB_TEXT                          [Utils colorWithHexString:@"#a3a3a3"]
#define COLOR_RED                               [Utils colorWithHexString:@"#b0021b"]
#define COLOR_RED_DOWN                          [Utils colorWithHexString:@"#9b0218"]
#define COLOR_LIGHT_RED                         [Utils colorWithHexString:@"#f04848"]
#define COLOR_SEP                               [Utils colorWithHexString:@"#ededed"]
#define COLOR_BG_GRAY                           [Utils colorWithHexString:@"#f0f0f0"]
#define COLOR_BG_GRAY_DOWN                      [Utils colorWithHexString:@"#dcdcdc"]
#define COLOR_BG_SIDEBAR                        [Utils colorWithHexString:@"#27262b"]

#define COLOR_BORDER                            [Utils colorWithHexString:@"#a7a7aa"]
#define COLOR_WEB_BG                            [Utils colorWithHexString:@"#f0f0f0"]


#define COLOR_NAVIGATIONBAR_TINTCOLER           [Utils colorWithHexString:@"#86B9D8"]
#define COLOR_NAVIGATIONBAR_BACK_COLOR          [UIColor whiteColor]
#define COLOR_NAVIGATIONBAR_BACK_IMAGE          [UIImage imageNamed:@"back-25.png"]//nav_back.png
#define COLOR_NAVIGATIONBAR_BACK_imageInsets    UIEdgeInsetsMake(5, 0, 0, 6) //UIEdgeInsetsMake(5, 0, 5, 10)

#define COLOR_NAVIGATIONBAR_right_imageInsets    UIEdgeInsetsMake(17, 25, 10, 5)

//评论图标
#define INFO_comment_ico                [UIImage imageNamed:@"icon_comment.png"]
#define INFO_comment_ico_imageInsets    UIEdgeInsetsMake(5, 6, 0, 0)

#define FSIZE_MAIN                              14.0f
#define FSIZE_SUB                               12.0f
#define FSIZE_INPUT                             16.0f
#define FSIZE_TITLE                             18.0f
#define FSIZE_NAV_TITLE                         20.0f
#define FONT_MAIN                               [Utils fontOfSize:FSIZE_MAIN]
#define FONT_SUB                                [Utils fontOfSize:FSIZE_SUB]
#define FONT_TITLE                              [Utils fontOfSize:FSIZE_TITLE]
#define FONT_INPUT                              [Utils fontOfSize:FSIZE_INPUT]
#define FONT_NAV_TITLE                          [Utils fontOfSize:FSIZE_NAV_TITLE]

#define SIZE_PADDING                            15.0f
#define SIZE_PADDING_SMALL                      10.0f
#define SIZE_PADDING_MICRO                      5.0f
#define SIZE_PADDING_BIG                        20.0f

#define WIDTH_CELL_IMAGE                        70.0f
#define HEIGHT_CELL_IMAGE                       52.0f

#define WIDTH_SIDEBAR                           240.0f

#define HEIGHT_SLIDER                           150.0f
#define HEIGHT_TABLE_CELL                       86.0f
#define HEIGHT_SEARCH_BAR                       40.0f
#define HEIGHT_NAV_VIEW                         35.0f
#define HEIGHT_BOTTOM_BAR                       44.0f

#define PAGESIZE                                10

#define ALERT_CALL                              1000
#define ALERT_LOGIN                             1001
#define ALERT_LOGOUT                            1002
#define ALERT_DELETE                            1003

#define KEY_SUBSCRIBE                           @"KEY_SUBSCRIBE"
#define KEY_SCORLL_POSITION                     @"KEY_SCORLL_POSITION"
#define KEY_USER                                @"KEY_USER"

#define KEY_LAUNCH_URL                          @"KEY_LAUNCH_URL"
#define KEY_LAUNCH_TYPE                         @"KEY_LAUNCH_TYPE"
#define KEY_LAUNCH_TYPE_ID                      @"KEY_LAUNCH_TYPE_ID"

#define NOTIFICATION_SUBSCRIBE_CHANGED          @"NOTIFICATION_SUBSCRIBE_CHANGED"
#define NOTIFICATION_CONFIG_LOADED              @"NOTIFICATION_CONFIG_LOADED"
#define NOTIFICATION_LOGIN                      @"NOTIFICATION_LOGIN"
#define NOTIFICATION_LOGOUT                     @"NOTIFICATION_LOGOUT"
#define NOTIFICATION_LAUNCH_IMAGE_CLICKED       @"NOTIFICATION_LAUNCH_IMAGE_CLICKED"
#define NOTIFICATION_REFRESH_MAINCONTROLLER     @"NOTIFICATION_REFRESH_MAINCONTROLLER"  //刷新主页面通知

#define NOTIFICATION_REFRESH_OPENNEWS           @"NOTIFICATION_REFRESH_OPENNEWS"  //打开新闻主页面
#define NOTIFICATION_REFRESH_INDEX_REFESESH     @"NOTIFICATION_REFRESH_INDEX_REFESESH"  //首页跳转
#define NOTIFICATION_REFRESH_WEBVIEW_REFESESH   @"NOTIFICATION_REFRESH_WEBVIEW_REFESESH"

#define CAT_TABLE                               0
#define CAT_PIC                                 1
#define CAT_WEB                                 2

#define NEWS_TYPE_NEWS                          @"news"
#define NEWS_TYPE_VOTE                          @"vote"
#define NEWS_TYPE_PICTURE                       @"pic"
#define NEWS_TYPE_SPECIAL                       @"special"

#define FLOW_PRESENT                            0
#define FLOW_PUSH                               1

#define API_KEY_WX                              @"wxe42e87a92b81f34b"

#define INIT_SQL1 @"CREATE  TABLE  IF NOT EXISTS 'fav' ('fav_id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 'fav_type' TEXT, 'fav_type_id' TEXT, 'fav_json' TEXT)"


//+(User *)me;
//+(void)setMe:(User *)m;


+(NSMutableArray *)links;
+(void)setLinks:(NSMutableArray *)arr;

+(UIFont *)fontOfSize:(CGFloat)s;

+(NSString *)imageUrlWithName:(NSString *)name;

+(void)saveString:(NSString *)str forKey:(NSString *)key;
+(NSString *)getStringForKey:(NSString *)key;
+(void)clearValueForKey:(NSString *)key;

+(NSMutableArray *)subscribes;
+(void)loadSubscribeFromSave;
+(void)initSubscribes:(NSMutableArray *)cats all:(NSMutableArray *)allcats ;
+(void)setSubscribes:(NSMutableArray *)cats;
+(void)saveSubscribes;
+(BOOL)subscribed:(int)cid;

+(void)refreshSubscribesFormatted;

+(UIColor *)colorWithHexString:(NSString *)stringToConvert;

//利用正则表达式验证
+(BOOL)isValidateEmail:(NSString *)email;

//首页内容的高度
+(int)mainContentHight;
//是否有网络
+(BOOL)isNetwork;
+(UIImage *)getLodingImage;
@end
