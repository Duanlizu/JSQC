//
//  ShopDetailViewController.m
//  JSzulin
//
//  Created by 王洋 on 2019/8/18.
//  Copyright © 2019年 yyy. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "YGLoginViewController.h"


@interface ShopDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name1;
@property (weak, nonatomic) IBOutlet UIImageView *image1;

@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UILabel *price1;

@property (weak, nonatomic) IBOutlet UILabel *dayNum;

@property (weak, nonatomic) IBOutlet UIButton *jianBtn;

@end

@implementation ShopDetailViewController

- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)numberasdasd:(id)sender {
    UIButton * btn = sender;
    if (btn.tag==1000) {
        
        if ([self.dayNum.text integerValue]>1) {
            NSInteger a = [self.dayNum.text integerValue]-1;
            self.dayNum.text = [NSString stringWithFormat:@"%lu",a];
        }
        
    }else if (btn.tag==1001){
        
        NSInteger a = [self.dayNum.text integerValue]+1;
        self.dayNum.text = [NSString stringWithFormat:@"%lu",a];
        
    }
    
}

- (IBAction)didClickBottomBtn:(id)sender {
    
    NSString * login = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN];
    if ([login isEqualToString:@"1"]) {
        //存数据
        NSMutableArray *arr = [NSMutableArray array];
        [arr addObjectsFromArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"weiFuKuan"]];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:self->_dic];
        [dic setObject:self->_dayNum.text forKey:@"number"];
        [arr insertObject:dic atIndex:0];
        [[NSUserDefaults standardUserDefaults]setObject:arr forKey:@"weiFuKuan"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [SVProgressHUD showSuccessWithStatus:@"已加入购物车"];
        [self performSelector:@selector(popove) withObject:nil afterDelay:0.5];
        
    }else{
        YGLoginViewController *login = [[YGLoginViewController alloc]init];
        UINavigationController *navc  = [[UINavigationController alloc]initWithRootViewController:login];
        login.title = @"登陆";
        login.loginScuccsse = ^{
          
        };
        [self presentViewController:navc animated:YES completion:nil];
    }
    
   
}


-(void)popove{
    [self.navigationController popToRootViewControllerAnimated:YES];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jianBtn.layer.masksToBounds = YES;
    self.jianBtn.layer.borderWidth = 0.5;
    self.jianBtn.layer.borderColor = ssRGBHex(0x505050).CGColor;
    [self setSubviews];
    // Do any additional setup after loading the view from its nib.
}

-(void)setSubviews{
    
    self.name1.text = _dic[@"name"];
    [self.image1 setImage:[UIImage imageNamed:_dic[@"image"]]];
    self.subtitle.text = _dic[@"subTile"];
    self.price1.text = [NSString stringWithFormat:@"%@",_dic[@"price"]];
    
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
