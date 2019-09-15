//
//  RigsetViewController.m
//  JSzulin
//
//  Created by mc on 2019/8/20.
//  Copyright © 2019 yyy. All rights reserved.
//

#import "RigsetViewController.h"

@interface RigsetViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *password1;

@property (weak, nonatomic) IBOutlet UITextField *password2;

@property (nonatomic , strong) NSMutableArray * userDataArr;

@end

@implementation RigsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    _userDataArr = [NSMutableArray arrayWithCapacity:10];
    [_userDataArr addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"userlist"]];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)rigsetUser:(id)sender {
    
    if ([self invidText]) {

    //存
    for (NSDictionary * dic in _userDataArr) {
        if ([dic[@"phone"] isEqualToString:_phoneNumber.text]) {
            [SVProgressHUD showInfoWithStatus:@"该号码已注册"];
            return;
        }
    }

        NSDictionary * dic = @{@"phone":_phoneNumber.text,@"password":_password1.text};
        [_userDataArr addObject:dic];
        [[NSUserDefaults standardUserDefaults]setObject:_userDataArr forKey:@"userlist"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL)invidText{
    
    if ([_phoneNumber.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请填写电话号码"];
        return NO;
    }
    
    if ([_password1.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return NO;
    }
    
    if ([_password2.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码"];
        return NO;
    }
    
    if (![_password2.text isEqualToString:_password1.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
        return NO;
    }
    
    return YES;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
