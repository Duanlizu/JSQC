//
//  YGLoginViewController.m
//  YouGu
//
//  Created by mc1 on 2019/6/18.
//  Copyright © 2019 kou. All rights reserved.
//

#import "YGLoginViewController.h"
#import "YGMainTabViewController.h"
#import "RigsetViewController.h"


@interface YGLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;//电话号码
@property (weak, nonatomic) IBOutlet UITextField *code;//验证码或密码

@property(nonatomic , strong) NSMutableArray * userDataArr;
@end

@implementation YGLoginViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_userDataArr addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"userlist"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    _userDataArr = [NSMutableArray arrayWithCapacity:10];
    
    [self addRightBtn];
}

- (void)addRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)onClickedOKbtn {
    [_phoneNumber resignFirstResponder];
    [_code resignFirstResponder];
    YGMainTabViewController *vc = [[YGMainTabViewController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

//登录
- (IBAction)Login:(UIButton *)sender {
    
    [_phoneNumber resignFirstResponder];
    [_code resignFirstResponder];
    
    if ([self.phoneNumber.text isEqualToString:@"15588889999"]&&[self.code.text isEqualToString:@"123456"]){
        _loginScuccsse();
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:LOGIN];
        [[NSUserDefaults standardUserDefaults]synchronize];

        YGMainTabViewController *vc = [[YGMainTabViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = vc;
       
        return;
    }else{
        
        for (int i =0; i<_userDataArr.count; i++) {
            NSDictionary * dic = _userDataArr[i];
            if ([_phoneNumber.text isEqualToString:dic[@"phone"]]&&[_code.text isEqualToString:dic[@"password"]]) {
                _loginScuccsse();
                [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:LOGIN];
                [[NSUserDefaults standardUserDefaults]synchronize];
                YGMainTabViewController *vc = [[YGMainTabViewController alloc]init];
                [UIApplication sharedApplication].keyWindow.rootViewController = vc;
                return;
            }
        }
    }
    
    [SVProgressHUD showErrorWithStatus:@"请您检查账号和密码是否正确"];

    
}

- (IBAction)rigsetView:(id)sender {
    
    RigsetViewController * rigsetvc = [[RigsetViewController alloc] init];
    
    [self.navigationController pushViewController:rigsetvc animated:YES];
    
}



@end
