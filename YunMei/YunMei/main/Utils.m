//
//  Utils.m
//  NingboFirstHospital
//
//  Created by Tianwei on 14-4-3.
//  Copyright (c) 2014年 jhcm. All rights reserved.
//

#import "Utils.h"
//#import "Cat.h"


static NSMutableArray *links;
static NSMutableArray *subscribes;
@implementation Utils




+(void)setLinks:(NSMutableArray *)arr{
    links = arr;
}

+(NSMutableArray *)links{
    return links;
}

+(NSString *)imageUrlWithName:(NSString *)name{
    return [NSString stringWithFormat:@"%@%@",IMAGE_URL,name];
}

+(UIFont *)fontOfSize:(CGFloat)s{
    return [UIFont fontWithName:@"FZLanTingHeiS-R-GB" size:s];
}

+(void)saveString:(NSString *)str forKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:str forKey:key];
    [defaults synchronize];
}

+(void)clearValueForKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

+(NSString *)getStringForKey:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults valueForKey:key];
}

+(NSString *)url:(NSString *)url appendGetKey:(NSString *)k value:(NSString *)v hasAnd:(BOOL)b{
    NSString *res = [url stringByAppendingFormat:@"%@%@=%@",b?@"&":@"",k,v];
    return res;
}


+(NSMutableArray *)subscribes{
    return subscribes;
}




+(UIColor *)colorWithHexString:(NSString *)stringToConvert{

    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}



//利用正则表达式验证
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



//自定长宽
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

@end
