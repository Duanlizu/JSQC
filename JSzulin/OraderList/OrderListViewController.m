//
//  OrderListViewController.m
//  JSzulin
//
//  Created by 王洋 on 2019/8/17.
//  Copyright © 2019年 yyy. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListCellTableViewCell.h"
#import "OrderFooterView.h"
#import "YGLoginViewController.h"

@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    OrderFooterView * footerview;
}
@property (weak, nonatomic) IBOutlet UILabel *placeHoder;

@property (weak, nonatomic) IBOutlet UITableView *bottomTableview;
@property (nonatomic , strong)NSMutableArray * dataArray;
@end

@implementation OrderListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self.bottomTableview reloadData];
}

-(void)loadfooterview{
    footerview = [OrderFooterView loadWithXib];
    __weak typeof(self) weakSelf = self;
    footerview.allBtnPrice = ^{
        
        NSString * login = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN];
        if ([login isEqualToString:@"1"]) {
          
            [weakSelf loginSuanji];
            
        }else{
            YGLoginViewController *login = [[YGLoginViewController alloc]init];
            UINavigationController *navc  = [[UINavigationController alloc]initWithRootViewController:login];
            login.title = @"登陆";
            login.loginScuccsse = ^{

            };
            [weakSelf presentViewController:navc animated:YES completion:nil];
        }
        
      
        
    };
}


-(void)loginSuanji{
    NSMutableArray * fukuanArr = [NSMutableArray arrayWithCapacity:10];
    [fukuanArr addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"FuKuan"]];
    int ins = (int)self.dataArray.count;
    for (int i= ins; i>0; i--) {
        [fukuanArr insertObject:self.dataArray[i-1] atIndex:0];
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:fukuanArr forKey:@"FuKuan"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self.dataArray removeAllObjects];
    [[NSUserDefaults standardUserDefaults]setObject:self.dataArray forKey:@"weiFuKuan"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self performSelector:@selector(persindsn) withObject:nil afterDelay:0.5];
}

-(void)persindsn{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"租赁预约成功" message:@"店家会跟您联系,请按照预约时间到店支付订单." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.bottomTableview reloadData];
    }];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:NULL];
}

-(void)allprice{
    NSInteger allp = 0;
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"weiFuKuan"]];
    
    for (NSDictionary *dic in self.dataArray) {
        NSInteger  b = [dic[@"price"] integerValue]*[dic[@"number"]integerValue];
        allp = allp+b;
    }
    [footerview.btn setTitle:[NSString stringWithFormat:@"总额：¥%lu",allp] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadfooterview];
    // Do any additional setup after loading the view from its nib.
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }return _dataArray;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"weiFuKuan"]];
    [self allprice];
    if (self.dataArray.count!=0) {
        self.placeHoder.hidden = YES;
    }else{
        self.placeHoder.hidden = NO;
    }
    
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = self.dataArray[indexPath.section];
    OrderListCellTableViewCell * cell = [OrderListCellTableViewCell cellWithXibAndTableview:tableView];
    cell.dic = dic;
    NSMutableArray * subArr = [NSMutableArray arrayWithArray:self.dataArray];
    
    cell.DelectBtn = ^(NSDictionary *dic) {
        for (NSDictionary * sdic in subArr) {
            if (sdic==dic) {
                [self.dataArray removeObject:sdic];
                
                [[NSUserDefaults standardUserDefaults]setObject:self.dataArray forKey:@"weiFuKuan"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [self.bottomTableview reloadData];
            }
        }
        
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 4.0f;
    }
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.dataArray.count!=0&&section==self.dataArray.count-1) {
        return 112;
    }
    return 0.01f;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.dataArray.count!=0&&section==self.dataArray.count-1) {
        return footerview;
    }return nil;
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
