//
//  MD5.h
//  登陆
//
//  Created by MAC on 2022/8/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MD5 : NSObject

+ (NSString *)md5To32bit:(NSString *)str;

+ (BOOL)checkPassword:(NSString *)password;

+ (BOOL)checkPhone:(NSString *)phone;
@end

NS_ASSUME_NONNULL_END
