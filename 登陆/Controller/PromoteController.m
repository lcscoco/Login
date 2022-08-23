//
//  PromoteController.m
//  登陆
//
//  Created by MAC on 2022/8/16.
//

#import "PromoteController.h"
#import "LCMessageCell.h"
#import "MyHelper.h"
#import "User.h"

@interface PromoteController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dict;

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UIButton *sousuo;

- (IBAction)updatePasswordBtn;
- (IBAction)exitBtn;

- (IBAction)didEndOnExit;

@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSArray *arrAccounts;



@end


@implementation PromoteController



- (NSMutableDictionary *)dict{
    if(!_dict){
        _dict = [[NSMutableDictionary alloc] init];
    }
    return _dict;
}

- (User *)user
{
    if(_user == nil){
        _user = [User sharedUser];
    }
    return _user;
}

- (NSArray *)arrAccounts
{
    if(_arrAccounts == nil){
        _arrAccounts = [[NSArray alloc] init];
    }
    return _arrAccounts;
}

+ (void)initialize{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    

    

    
    
    //背景
    UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [backImageView setImage:[UIImage imageNamed:@"背景"]];
    [self.view insertSubview:backImageView atIndex:0];
    
    self.searchView.layer.cornerRadius = self.searchView.frame.size.height/2;
    self.inputText.borderStyle = UITextBorderStyleNone; //去除输入框边框
    self.sousuo.layer.cornerRadius = self.sousuo.frame.size.height/2;
    
    //tableview背景
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    [self.navigationItem setHidesBackButton:YES]; //隐藏返回按钮
 
    self.navigationItem.title = [NSString stringWithFormat:@"%@·%@",self.user.department,self.user.regname];
    
    
    
    //加载数据
    [MyHelper selectAccounts:self.user.phone phone:@"" view:self.view block:^(NSArray * _Nonnull arr) {

        self.arrAccounts = arr;

        if(arr == nil){
            [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
        }else{
            [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleSingleLine];
        }
        
       
        [self.tableView reloadData];
        
        
        
    }];

    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrAccounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.dict = self.arrAccounts[indexPath.row];
    LCMessageCell *cell = [LCMessageCell messageCellWithTableView:tableView dict:self.dict];
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [self.view endEditing:YES];
}


- (IBAction)exitBtn {
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)updatePasswordBtn {
    
    [MyHelper showIndex:@"Department" isId:@"updatePassword" navigation:self.navigationController navigationItem:self.navigationItem];
    
}
    
//search
- (IBAction)didEndOnExit {

    NSString *managerPhone = self.user.phone;
    NSString *phone = self.inputText.text;
    
    [self.view endEditing:YES];
    [MyHelper selectAccounts:managerPhone phone:phone view:self.view block:^(NSArray * _Nonnull arr) {
        self.arrAccounts = arr;
        if(arr == nil){
            [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
        }else{
            [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleSingleLine];
        }

        
        [self.tableView reloadData];
    }];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.view endEditing:YES];
}
@end


