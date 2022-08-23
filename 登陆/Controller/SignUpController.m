//
//  SignUpController.m
//  登陆
//
//  Created by MAC on 2022/7/28.
//

#import "SignUpController.h"
#import "UIView+Toast.h"
#import "ViewController.h"
#import "MyHelper.h"
#import "MD5.h"
#import "LCMenu.h"
#import <Masonry/Masonry.h>

@interface SignUpController () <UITextFieldDelegate,LCMenuDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
- (IBAction)SignUp;
@property (weak, nonatomic) IBOutlet UIButton *signUpbtn;
@property (weak, nonatomic) IBOutlet UIButton *xzBtn;
- (IBAction)xzBtnClick;

@property (nonatomic, strong) UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UITextField *deparment;

@property (weak, nonatomic) IBOutlet UIButton *depramentLayout;
- (IBAction)deparmentBtn;


@property (nonatomic, assign) int choose;




@property (nonatomic, assign) int index;


@property (nonatomic, strong) NSMutableDictionary *dict;

@property (nonatomic, strong) LCMenu *menu;

@end

@implementation SignUpController

- (LCMenu *)menu{
    if(_menu == nil){
        _menu = [LCMenu menuWithView];
        [self.view addSubview:_menu];
        [_menu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.deparment.mas_bottom);
            make.left.mas_equalTo(self.deparment.mas_left);
            make.width.mas_equalTo(self.deparment.mas_width);
            make.height.equalTo(@90);
        }];
        _menu.delegate = self;
    }
    return _menu;
}

- (NSMutableDictionary *)dict
{
    if(_dict == nil){
        _dict = [[NSMutableDictionary alloc] init];
    }
    return _dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"用户注册";
    
    self.signUpbtn.layer.cornerRadius = 5;

    
    //背景
    UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [backImageView setImage:[UIImage imageNamed:@"背景"]];
    [self.view insertSubview:backImageView atIndex:0];
    

    [self.xzBtn setTintColor:[UIColor blackColor]];
    [self.xzBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    self.xzBtn.contentEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    _index = 0;
    
    
    _password.textContentType = UITextContentTypeName;
    _confirmPassword.textContentType = UITextContentTypeName;
    


    [self dropDownBox:NO];
    
    self.name.delegate = self;
    self.phone.delegate = self;
    self.deparment.delegate = self;
    self.password.delegate = self;
    self.confirmPassword.delegate = self;
    
    

}





- (IBAction)SignUp {
    NSString *name = _name.text;
    NSString *phone = _phone.text;
    NSString *deparment = _deparment.text;
    NSString *password = _password.text;
    NSString *confirmPassword = _confirmPassword.text;
    
    
    self.dict[@"phone"] = phone;
    self.dict[@"password"] = password;
    if(_index == 1){
        
        [MyHelper insertUser:name phone:phone deparment:deparment password:password conPassword:confirmPassword view:self.view block:^{
            
            
            
            [self showIndex];
        
        }];
        
    }else{
//        [self showAlertView:@"请阅读并勾选《服务协议》、《隐私政策》" msg:nil];
        [self.view makeToast:@"请阅读并勾选《服务协议》、《隐私政策》" duration:2.0 position:CSToastPositionCenter];
    }
    
    
    
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.view endEditing:YES];
}






- (void)showIndex
{
    ViewController *setPrizeVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    //初始化其属性
    setPrizeVC.dict = nil;
    //传递参数过去
    setPrizeVC.dict = [NSMutableDictionary dictionaryWithDictionary:self.dict];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)xzBtnClick {
    if(_index == 0){
        [self.xzBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
        [self.xzBtn setTintColor:[UIColor redColor]];
        _index = 1;
    }else if(_index == 1){
        [self.xzBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
        [self.xzBtn setTintColor:[UIColor blackColor]];
        _index = 0;
    }
    
}


- (IBAction)deparmentBtn {

    if(_choose == 0){
        [self dropDownBox:YES];

        
    }else{
        [self dropDownBox:NO];

    }


}




- (void)dropDownBox:(BOOL)check
{
    [self.depramentLayout setTintColor:[UIColor blackColor]];
    if(check){
        self.choose = 1;
        [self.menu setHidden:NO];
        [self.depramentLayout setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        self.depramentLayout.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    }else{
        self.choose = 0;
        [self.menu setHidden:YES];
        [self.depramentLayout setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        self.depramentLayout.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    }
}

- (void)checkClick:(UIButton *)button{
    switch (button.tag) {
        case 1:
            self.deparment.text = @"技术信息部";
            break;
        case 2:
            self.deparment.text = @"运营部";
            break;
        case 3:
            self.deparment.text = @"推广部";
            break;
    }
    [self dropDownBox:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //判断
    NSString *text = textField.text;
    switch (textField.tag) {
        //name
        case 1:
            if([text isEqual:@""]){
                [self.view makeToast:@"呢称不能为空" duration:1.0 position:CSToastPositionCenter];
            }
            break;
        //phone
        case 2:
            if(![MD5 checkPhone:text]){
                [self.view makeToast:@"用户名必须为11位手机号" duration:1.0 position:CSToastPositionCenter];
            }
            break;
        //deparment
        case 3:
            if(!([text isEqual:@"技术信息部"] || [text isEqual:@"运营部"] || [text isEqual:@"推广部"]) ){
                [self.view makeToast:@"请选择对应部门" duration:1.0 position:CSToastPositionCenter];
            }
            break;
        //password
        case 4:
            if(![MD5 checkPassword:text]){
                [self.view makeToast:@"密码长度必须为8-16位并且包含大小写字母、数字" duration:1.0 position:CSToastPositionCenter];
            }
            break;

        //conPassword
        case 5:
            if(![MD5 checkPassword:text]){
                [self.view makeToast:@"密码长度必须为8-16位并且包含大小写字母、数字" duration:1.0 position:CSToastPositionCenter];
            }
            break;

    }
    
    
    

}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self dropDownBox:NO];
}
@end
