//
//  SettingViewController.m
//  JSzulin
//
//  Created by mc on 2019/8/19.
//  Copyright © 2019 yyy. All rights reserved.
//

#import "SettingViewController.h"
#import "YGLoginViewController.h"
#import "YGMainTabViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SettingViewController


- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (nil==cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"退出登录";
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:LOGIN];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    YGLoginViewController *login = [[YGLoginViewController alloc]init];
    UINavigationController *navc  = [[UINavigationController alloc]initWithRootViewController:login];
    login.title = @"登陆";
    login.loginScuccsse = ^{
        
    };
    [self presentViewController:navc animated:YES completion:nil];
    
  
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
