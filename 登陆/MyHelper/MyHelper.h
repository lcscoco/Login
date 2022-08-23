//
//  MyHelper.h
//  登陆
//
//  Created by MAC on 2022/8/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyHelper : NSObject



//登录
+ (void)login:(NSString *)phone password:(NSString *)password view:(UIView *)view block:(void(^)(void))myBlock;


//修改密码
+ (void)updatePassword:(NSString *)phone password:(NSString *)password conPassword:(NSString *)conPassword view:(UIView *)view block:(void(^)(void))myBlock;

//跳转
+ (void)showIndex:(NSString *)name isId:(NSString *)ids navigation:(UINavigationController *)navigation navigationItem:(UINavigationItem *)navigationItem;

//注册
+ (void)insertUser:(NSString *)name phone:(NSString *)phone deparment:(NSString *)deparment password:(NSString *)password conPassword:(NSString *)conPassword view:(UIView *)view  block:(void(^)(void))myBlock;

//查询信息
+ (void)selectAccounts:(NSString *)managerPhone phone:(NSString *)phone view:(UIView *)view block:(void(^)(NSArray *arr))myBlock;


//检查
+ (void)check:(UITextField *)textField lastPassword:(NSString *)lastPassword conPassword:(NSString *)conPassword view:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
