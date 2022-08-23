//
//  MD5.m
//  登陆
//
//  Created by MAC on 2022/8/16.
//

#import "MD5.h"
#import "CommonCrypto/CommonDigest.h"

@implementation MD5

+ (NSString *)md5To32bit:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr),digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
      [result appendFormat:@"%02x", digest[i]];
    return result;
}

//密码格式
+ (BOOL)checkPassword:(NSString *)password
{
    NSString *pattern = @"^(?![A-Za-z0-9]+$)(?![a-z0-9\\W]+$)(?![A-Za-z\\W]+$)(?![A-Z0-9\\W]+$)[a-zA-Z0-9\\W]{8,}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}


//用户名格式
+ (BOOL)checkPhone:(NSString *)phone
{
    NSString *pattern = @"^[1][3,4,5,7,8][0-9]{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:phone];
    return isMatch;
}

@end
