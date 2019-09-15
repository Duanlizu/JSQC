//
//  ListaViewController.m
//  JSzulin
//
//  Created by mc on 2019/8/23.
//  Copyright © 2019 yyy. All rights reserved.
//

#import "ListaViewController.h"
#import "HomeCollectionViewCell.h"
#import "ShopDetailViewController.h"

@interface ListaViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic , strong) UICollectionView* collectionView;
@property (nonatomic , strong) NSMutableArray * dataArr;
@property (nonatomic , strong) NSMutableArray * dataArr2;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ListaViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_ishiddLeft) {
        self.backBtn.hidden = NO;
    }
    [_tableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:_a inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    // Do any additional setup after loading the view from its nib.
    [self setclletionView];
    
    self.dataArr = [[NSMutableArray alloc] initWithCapacity:10];
    self.dataArr2 = [[NSMutableArray alloc] initWithCapacity:10];

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"orderList" ofType:@"plist"];
    
    NSMutableArray * dataaeeee = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    
    for (int i = 0; i<dataaeeee.count; i++) {
        if (i==0) {
            [self.dataArr addObject:dataaeeee[i]];
        }else{
            [self.dataArr2 addObject:dataaeeee[i]];
        }
    }

    [self.collectionView reloadData];
}

-(void)setclletionView{
    
    /**
     创建layout
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = (kScreenWidth*2/3-(kLineNum+1)*kLineSpacing)/kLineNum-0.1;
    layout.itemSize = CGSizeMake(itemW, itemW*1.1);
    
    /**
     注册item和区头视图、区尾视图
     */
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(kScreenWidth/3, NAVIGATION_BAR_HEIGHT, kScreenWidth*2/3, kScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = ssRGBHex(0xf6f6f6);
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * Identifier = @"leftcell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (nil==cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    if (indexPath.row==0) {
        cell.textLabel.text = @"球类";
    }else{
        cell.textLabel.text = @"器械类";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _a = indexPath.row;
    [_collectionView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
/**
 每个分区item的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_a==0) {
        return self.dataArr.count;
    }
    return self.dataArr2.count;
}
/**
 创建cell
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    if (_a==0) {
        NSDictionary * dic =  self.dataArr[indexPath.row];
        [cell.image1 setImage:[UIImage imageNamed:dic[@"image"]]];
        cell.name1.text = dic[@"name"];
        cell.price1.text = [NSString stringWithFormat:@"¥%@/天",dic[@"price"]];
        return cell;
        
    }else if (_a==1){
        NSDictionary * dic =  self.dataArr2[indexPath.row];
        [cell.image1 setImage:[UIImage imageNamed:dic[@"image"]]];
        cell.name1.text = dic[@"name"];
        cell.price1.text = [NSString stringWithFormat:@"¥%@/天",dic[@"price"]];
        return cell;
        
    }
    return nil;
    
}
/**
 创建区头视图和区尾视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
      
    }
    return nil;
    
}
/**
 点击某个cell
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld分item",(long)indexPath.item);
    NSDictionary * dic ;
    if (_a==0) {
        dic =  self.dataArr[indexPath.row];
    }else if (_a==1){
        dic =  self.dataArr2[indexPath.row];
    }
    ShopDetailViewController * svc = [[ShopDetailViewController alloc] init];
    svc.dic = dic;
    svc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:svc animated:YES];
}

/**
 每个分区的内边距（上左下右）
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kLineSpacing, kLineSpacing, kLineSpacing, kLineSpacing);
}
/**
 分区内cell之间的最小行间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kLineSpacing;
}
/**
 分区内cell之间的最小列间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kLineSpacing;
}
/**
 区头大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth*2/3, 0);
}
/**
 区尾大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth*2/3, 0);
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
