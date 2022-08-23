//
//  MyHelper.m
//  登陆
//
//  Created by MAC on 2022/8/16.
//

#import "MyHelper.h"
#import "AFNetworking/AFNetworking.h"
#import "UIView+Toast.h"
#import "MD5.h"
#import "User.h"

#define loginApi @"http://119.96.82.181:8081/WS_Administration/login"
#define updatePasswordApi @"http://119.96.82.181:8081/WS_Administration/updatePasswordByPhone"
#define selectApi @"http://119.96.82.181:8081//WS_Administration/findUser"


@implementation MyHelper


//登录
+ (void)login:(NSString *)phone password:(NSString *)password view:(UIView *)view block:(void(^)(void))myBlock
{
    NSLog(@"hello3333 %@",[NSThread currentThread]);
    if([phone isEqual: @""]){

        [view makeToast:@"请输入用户名" duration:2.0 position:CSToastPositionCenter];
        return;
    }else if([password isEqual:@""]){

        [view makeToast:@"请输入密码" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    
    NSString *mdPassword = [MD5 md5To32bit:password];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"phone"] = phone;
    parameters[@"password"] = mdPassword;

    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    
    [mgr GET:loginApi parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {


        NSString *flag = responseObject[@"flag"];
        NSString *data = responseObject[@"data"];
        
        if([flag isEqual: @"success"]){
            NSDictionary *dict = responseObject[@"data"][0];
            
            User *user = [User sharedUser];
            user.phone = dict[@"phone"];
            user.department = dict[@"department"];
            user.regname = dict[@"regname"];
            
            
            myBlock();

        }else{

            [view makeToast:data duration:2.0 position:CSToastPositionCenter];
        }


        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"------%@",error);

            [view makeToast:@"网络超时，请重试" duration:2.0 position:CSToastPositionCenter];
    }];


}

//修改密码
+ (void)updatePassword:(NSString *)phone password:(NSString *)password conPassword:(NSString *)conPassword view:(UIView *)view block:(void(^)(void))myBlock
{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"phone"] = phone;
    parameters[@"beforePassword"] = password;
    parameters[@"password"] = conPassword;
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];

    [mgr GET:updatePasswordApi parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {


        NSString *flag = responseObject[@"flag"];
        NSString *data = responseObject[@"data"];
        
        if([flag isEqual: @"success"]){
//            [self showIndex:@"Department" isId:@"promoteView"];
            myBlock();
           
            
        }else{

            [view makeToast:data duration:2.0 position:CSToastPositionCenter];
        }


        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"------%@",error);

            [view makeToast:@"网络超时，请重试" duration:2.0 position:CSToastPositionCenter];
    }];
}

//跳转
+ (void)showIndex:(NSString *)name isId:(NSString *)ids navigation:(UINavigationController *)navigation navigationItem:(UINavigationItem *)navigationItem
{
    //跳转
    UIStoryboard *story = [UIStoryboard storyboardWithName:name bundle:[NSBundle mainBundle]];
   //在Storyboard中经过ID获取到ViewController
    UIViewController *con = [story instantiateViewControllerWithIdentifier:ids];
    [navigation pushViewController:con animated:YES];
    navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    navigation.navigationBar.tintColor = [UIColor grayColor];
    navigation.interactivePopGestureRecognizer.enabled = NO;  //禁用滑动手势
    
}

//注册
+ (void)insertUser:(NSString *)name phone:(NSString *)phone deparment:(NSString *)deparment password:(NSString *)password conPassword:(NSString *)conPassword view:(UIView *)view  block:(void(^)(void))myBlock
{
    if([name isEqual: @""] || [phone isEqual: @""] || [password isEqual: @""] || [conPassword isEqual: @""] ){
        [view makeToast:@"信息不完整" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    
    
    if(![MD5 checkPhone:phone]){
        [view makeToast:@"用户名必须为11位手机号" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    
    if(!([deparment isEqual:@"技术信息部"] || [deparment isEqual:@"运营部"] || [deparment isEqual:@"推广部"]) ){
        [view makeToast:@"请选择对应部门" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if(![MD5 checkPassword:password]){
        [view makeToast:@"密码长度必须为8-16位并且包含大小写字母、数字、特殊字符" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    
     
    NSString *encryptPassword = [MD5 md5To32bit:password];
    if(![password isEqual:conPassword]){
        [view makeToast:@"两次密码输入不一致" duration:2.0 position:CSToastPositionCenter];
        return;
    }

    
    NSString *urlStr = @"http://119.96.82.181:8081/WS_Administration/regist";
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSLog(@"name=%@,phone=%@,password=%@",name,phone,password);
    parameters[@"regname"] = name;
    parameters[@"phone"] = phone;
    parameters[@"password"] = encryptPassword;
    parameters[@"deptId"] = @"";
    parameters[@"sex"] = @"";
    parameters[@"age"] = @"";
    parameters[@"department"] = deparment;
    parameters[@"wsid"] = @"";
    parameters[@"address"] = @"";
    parameters[@"upload"] = @"";

    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];

    [mgr GET:urlStr parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSString *flag = responseObject[@"flag"];
        NSString *data = responseObject[@"data"];


        if([flag isEqual: @"success"]){
            myBlock();
     
            
        }else{
            [view makeToast:data duration:2.0 position:CSToastPositionCenter];
        }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"------%@",error);
            [view makeToast:@"网络超时，请重试" duration:2.0 position:CSToastPositionCenter];
        }];
}

//查询信息
+ (void)selectAccounts:(NSString *)managerPhone phone:(NSString *)phone view:(UIView *)view block:(void(^)(NSArray *arr))myBlock
{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"managerPhone"] = managerPhone;
    parameters[@"phone"] = phone;
    parameters[@"startPage"] = @"";
    parameters[@"pageSize"] = @"";

    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];

    [mgr GET:selectApi parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {


        NSString *flag = responseObject[@"flag"];
        NSString *data = responseObject[@"data"];
        
        if([flag isEqual: @"success"]){
            NSArray *arr = responseObject[@"data"];
            
//            NSLog(@"data=%@",arr);
//            NSLog(@"%lu",arr.count);
            myBlock(arr);
            
            
        }else{

            [view makeToast:data duration:2.0 position:CSToastPositionCenter];
            myBlock(nil);
        }


        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"------%@",error);

            [view makeToast:@"网络超时，请重试" duration:2.0 position:CSToastPositionCenter];
    }];
}

//检查
+ (void)check:(UITextField *)textField lastPassword:(NSString *)lastPassword conPassword:(NSString *)conPassword view:(UIView *)view
{
    NSString *text = textField.text;
    if(textField.tag != 1){
        if(![MD5 checkPassword:text]){
            [view makeToast:@"密码长度必须为8-16位并且包含大小写字母、数字、特殊字符" duration:2.0 position:CSToastPositionCenter];
            return;
        }
    }

    
}
@end
