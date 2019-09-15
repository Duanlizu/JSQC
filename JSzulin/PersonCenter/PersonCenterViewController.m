//
//  PersonCenterViewController.m
//  JSzulin
//
//  Created by 王洋 on 2019/8/17.
//  Copyright © 2019年 yyy. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "PersonTableViewCell.h"
#import "HisViewController.h"
#import "SettingViewController.h"
#import "YGLoginViewController.h"

@interface PersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *bottomTable;


@end

@implementation PersonCenterViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonTableViewCell * cell = [PersonTableViewCell cellWithXibAndTableview:tableView];
    if (indexPath.row==0) {
        [cell.image1 setImage:[UIImage imageNamed:@"icon-租赁记录"]];
        cell.text1.text = @"租赁记录";
    }else if(indexPath.row==1){
        [cell.image1 setImage:[UIImage imageNamed:@"icon-清除缓存"]];
        cell.text1.text = @"清除缓存";
    }else if (indexPath.row==2){
        [cell.image1 setImage:[UIImage imageNamed:@"icon-设置"]];
        cell.text1.text = @"设置";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        HisViewController * hvc = [[HisViewController alloc] init];
        hvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hvc animated:YES];
    }else if (indexPath.row==1){
        [self cleanMer];
    }else if (indexPath.row==2){
        SettingViewController * svc = [[SettingViewController alloc] init];
        svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:svc animated:YES];
    }
}

-(void)cleanMer{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否清理缓存？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancel];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self removeCache];
    }];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)removeCache{ //===============清除缓存==============
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    NSLog(@"文件数：%ld",[files count]);
    for(NSString *p in files){ NSError*error; NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error]; if(isRemove)
            {
                NSLog(@"清除成功");
            }else{
                NSLog(@"清除失败");
                
            }
            
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
