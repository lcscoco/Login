//
//  User.h
//  登陆
//
//  Created by MAC on 2022/8/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *department;
@property (nonatomic, copy) NSString *regname;

+ (instancetype)sharedUser;

@end

NS_ASSUME_NONNULL_END
