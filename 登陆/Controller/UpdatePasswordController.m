//
//  UpdatePasswordController.m
//  登陆
//
//  Created by MAC on 2022/8/17.
//

#import "UpdatePasswordController.h"
#import "MyHelper.h"
#import "User.h"
#import "ViewController.h"
#import "MD5.h"
#import "UIView+Toast.h"

@interface UpdatePasswordController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstPassword;
@property (weak, nonatomic) IBOutlet UITextField *lastPassword;
@property (weak, nonatomic) IBOutlet UITextField *conLastPassword;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;

- (IBAction)updateBtnClick;



@end

@implementation UpdatePasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //背景
    UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [backImageView setImage:[UIImage imageNamed:@"背景"]];
    [self.view insertSubview:backImageView atIndex:0];
    
    
    self.updateBtn.layer.cornerRadius = 5;
    
    self.firstPassword.delegate = self;
    self.lastPassword.delegate = self;
    self.conLastPassword.delegate = self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)updateBtnClick {
    
    NSLog(@"========");
    
    if([_firstPassword.text isEqual: @""] || [_lastPassword.text isEqual: @""] || [_conLastPassword.text isEqual: @""]){
        [self.view makeToast:@"信息不完整" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    if(![_lastPassword.text isEqual:_conLastPassword.text]){
        [self.view makeToast:@"两次密码输入不一致" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    if(![MD5 checkPassword:_lastPassword.text]){
        [self.view makeToast:@"密码长度必须为8-16位并且包含大小写字母、数字、特殊字符" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    
    NSString *firstPassword =  [MD5 md5To32bit:_firstPassword.text];
    NSString *lastPassword = [MD5 md5To32bit:_lastPassword.text];

    
    
    
    User *user = [User sharedUser];
    [MyHelper updatePassword:user.phone password:firstPassword conPassword:lastPassword view:self.view block:^{

        [self.view makeToast:@"修改成功" duration:1.0 position:CSToastPositionCenter];
  
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [MyHelper check:textField lastPassword:_lastPassword.text conPassword:_conLastPassword.text view:self.view];
    
}
@end
