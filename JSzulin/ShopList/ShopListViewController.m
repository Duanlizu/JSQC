//
//  ShopListViewController.m
//  JSzulin
//
//  Created by 王洋 on 2019/8/17.
//  Copyright © 2019年 yyy. All rights reserved.
//

#import "ShopListViewController.h"
#import "HomeCollectionViewCell.h"
#import "MyCollectionViewHeaderView.h"
#import "SDCycleScrollView.h"
#import "ShopDetailViewController.h"
#import "ListaViewController.h"

@interface ShopListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic , strong) UICollectionView* collectionView;
@property (weak, nonatomic) IBOutlet UIView *cview;
@property (nonatomic , strong) SDCycleScrollView * sdScrollview;
@property (nonatomic , strong) NSMutableArray * dataArr;
@end

@implementation ShopListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setclletionView];

    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"orderList" ofType:@"plist"];
    self.dataArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    [self.collectionView reloadData];
}

-(void)setclletionView{
    
    /**
     创建layout
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = (kScreenWidth-(kLineNum+1)*kLineSpacing)/kLineNum-0.1;
    layout.itemSize = CGSizeMake(itemW, itemW*1.1);

    /**
     注册item和区头视图、区尾视图
     */
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = ssRGBHex(0xf6f6f6);
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];

    [self.cview addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyCollectionViewHeaderView"];
}

- (SDCycleScrollView *)sdScrollview{
    if (!_sdScrollview) {
        _sdScrollview = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
        _sdScrollview.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _sdScrollview.currentPageDotColor = [UIColor whiteColor];
        _sdScrollview.pageDotColor = [UIColor lightGrayColor];
        _sdScrollview.delegate = self;
        _sdScrollview.currentPageDotImage = [self createImageWithColor:[UIColor whiteColor]];
        _sdScrollview.contentMode = UIViewContentModeScaleAspectFill;
        _sdScrollview.clipsToBounds = YES;
        _sdScrollview.pageDotImage = [self createImageWithColor:[UIColor grayColor]];
        _sdScrollview.pageControlDotSize = CGSizeMake(10, 4);
        _sdScrollview.localizationImageNamesGroup = @[@"健身器材banner",@"banner-2",@"banner-3"];
    }
    return _sdScrollview;
}

- (UIImage*)createImageWithColor: (UIColor*) color{CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);UIGraphicsBeginImageContext(rect.size);CGContextRef context = UIGraphicsGetCurrentContext();CGContextSetFillColorWithColor(context, [color CGColor]);CGContextFillRect(context, rect);UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();return theImage;}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
/**
 分区个数
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
/**
 每个分区item的个数
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
/**
 创建cell
 */
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    NSDictionary * dic =  self.dataArr[indexPath.row];
    [cell.image1 setImage:[UIImage imageNamed:dic[@"image"]]];
    cell.name1.text = dic[@"name"];
    cell.price1.text = [NSString stringWithFormat:@"¥%@/天",dic[@"price"]];
    return cell;
    
}
/**
 创建区头视图和区尾视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        MyCollectionViewHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MyCollectionViewHeaderView" forIndexPath:indexPath];
        headerView.bounds = CGRectMake(0, 0, kScreenWidth, 350);
        [headerView addSubview:self.sdScrollview];
        headerView.backgroundColor = ssRGBHex(0xf6f6f6);
        headerView.DidClickHot = ^(NSInteger tag) {
            ListaViewController * svc = [[ListaViewController alloc] init];
            svc.ishiddLeft = YES;
            svc.a = tag;
            svc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:svc animated:YES];
        };
        return headerView;
    }
    return nil;
    
}
/**
 点击某个cell
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld分item",(long)indexPath.item);
    NSDictionary * dic =  self.dataArr[indexPath.row];
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
    return CGSizeMake(kScreenWidth, 350);
}
/**
 区尾大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth, 0);
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
