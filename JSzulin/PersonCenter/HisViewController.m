//
//  HisViewController.m
//  JSzulin
//
//  Created by mc on 2019/8/19.
//  Copyright © 2019 yyy. All rights reserved.
//

#import "HisViewController.h"
#import "OrderListCellTableViewCell.h"

@interface HisViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *placeHoder;

@property (weak, nonatomic) IBOutlet UITableView *bottomTableview;

@property (nonatomic , strong)NSMutableArray * dataArray;

@end

@implementation HisViewController

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)cleanList:(id)sender {
    
    
    [self clean];
    
}

-(void)clean{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否清空历史订单？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancel];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self removeCache];
    }];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:NULL];
}

-(void)removeCache{
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSMutableArray arrayWithCapacity:10] forKey:@"FuKuan"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.bottomTableview reloadData];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }return _dataArray;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"FuKuan"]];
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
    cell.HisAllPrice=YES;
    cell.btnWidth.constant = 0;
    cell.dic = dic;
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
