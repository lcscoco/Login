//
//  ViewController.m
//  登陆
//
//  Created by MAC on 2022/7/15.
//

#import "ViewController.h"
#import "CommonCrypto/CommonDigest.h"
#import "MyHelper.h"
#import "SignUpController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *logoView;

@property (weak, nonatomic) IBOutlet UIImageView *logo;





@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UIImageView *emailLogo;
@property (weak, nonatomic) IBOutlet UIImageView *passwordLogo;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)login:(id)sender;
- (IBAction)stewardLogin:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *eyeBtn;
- (IBAction)eyeBtnClick:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;


@property NSInteger index;




@end


@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏透明
    //导航条透明,设置一个透明的背景图片或者一个nil image
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去除黑线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
    
    //背景
    UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [backImageView setImage:[UIImage imageNamed:@"背景"]];
    [self.view insertSubview:backImageView atIndex:0];
    
    
    //logo
    self.logoView.layer.cornerRadius = self.logoView.frame.size.width/2;
    self.logo.layer.cornerRadius = self.logo.frame.size.width/2;

    
    
    
    //inputView
    self.inputView.layer.cornerRadius = 5;
    
    //button
    self.button1.layer.cornerRadius = 5;
    self.button2.layer.cornerRadius = 5;
    self.button3.layer.cornerRadius = 5;

    //透明
    self.email.borderStyle = normal;
    self.password.borderStyle = normal;
    
    

    [self.eyeBtn setImage:[UIImage imageNamed:@"no_eye"] forState:UIControlStateNormal];
    _index = 0;
    
 

}



- (IBAction)stewardLogin:(id)sender {
    
//    [self showIndex:@"Main" isId:@"lastView"];
    [MyHelper showIndex:@"Main" isId:@"lastView" navigation:self.navigationController navigationItem:self.navigationItem];
}

- (IBAction)login:(id)sender {

    NSString *phone = _email.text ;
    NSString *password = _password.text;
    
    [MyHelper login:phone password:password view:self.view block:^{
        [MyHelper showIndex:@"Department" isId:@"promoteView" navigation:self.navigationController navigationItem:self.navigationItem];
        self.email.text = @"";
        self.password.text = @"";
    }];
        
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.view endEditing:YES];
}




//密码显示
- (IBAction)eyeBtnClick:(id)sender {
    
    if(_index == 0){
        [self.eyeBtn setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
        _password.secureTextEntry = NO;
        _index = 1;
    }else if(_index == 1){
        [self.eyeBtn setImage:[UIImage imageNamed:@"no_eye"] forState:UIControlStateNormal];
        _password.secureTextEntry = YES;
        _index = 0;
    }
    
}


//返回传参
-(void)viewDidAppear:(BOOL)animated
{
  //判断并接收返回的参数
    if(self.dict){
        self.email.text = self.dict[@"phone"];
        self.password.text = self.dict[@"password"];
        self.dict = nil;
    }

    

    
}


@end
