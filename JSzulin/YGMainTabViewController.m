//
//  YGMainTabViewController.m
//  YouGu
//
//  Created by mc1 on 2019/6/17.
//  Copyright © 2019 kou. All rights reserved.
//

#import "YGMainTabViewController.h"
#import "ShopListViewController.h"
#import "OrderListViewController.h"
#import "PersonCenterViewController.h"
#import "YGLoginViewController.h"
#import "ListaViewController.h"

@interface YGMainTabViewController ()<UITabBarControllerDelegate>

@end

@implementation YGMainTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    NSArray <NSDictionary *>*data = @[
                                      @{@"image": @"tab bar-icon-首页-未点击", @"selectedImage":@"tab bar-icon-首页-点击状态",@"title": @"首页", @"clsName": @"ShopListViewController"},
                                       @{@"image": @"tab-icon-分类-未点击", @"selectedImage":@"tab-icon-分类-点击状态",@"title": @"分类", @"clsName": @"ListaViewController"},
                                      @{@"image": @"tab bar-icon订单-未点击", @"selectedImage":@"tab bar-icon-订单-点击状态",@"title": @"购物车", @"clsName": @"OrderListViewController"},
                                      @{@"image": @"tab-icon-个人中心-未点击", @"selectedImage":@"tab bar-icon-个人中心-点击状态",@"title": @"个人中心", @"clsName": @"PersonCenterViewController"}];
    // 添加子控制器
    for (NSDictionary *dic in data) {
        Class c = NSClassFromString(dic[@"clsName"]);
        UIViewController *vc = [[c alloc]init];
        [self addChildViewControllerWithController:vc ImageName:dic[@"image"] sclectedImage:dic[@"selectedImage"] title:dic[@"title"]];
    }
    
}
// 添加子控制器
- (void)addChildViewControllerWithController:(UIViewController *)childController ImageName:(NSString *)image sclectedImage:(NSString *)selectedImage title:(NSString *)title{
    
    //设置导航栏控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childController];
    
    //设置tabbar自控制器
    nav.tabBarItem.title = title;
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [nav.tabBarItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrSelected[NSForegroundColorAttributeName] = [UIColor blackColor];
    [nav.tabBarItem setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    nav.tabBarItem.image = [UIImage imageNamed:image];
    
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    [self addChildViewController:nav];
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if (viewController == [tabBarController.viewControllers objectAtIndex:3]) {
        
        NSString * login = [[NSUserDefaults standardUserDefaults]objectForKey:LOGIN];
        if ([login isEqualToString:@"1"]) {
            
            return YES;
        }else{
            YGLoginViewController *login = [[YGLoginViewController alloc]init];
            UINavigationController *navc  = [[UINavigationController alloc]initWithRootViewController:login];
            login.title = @"登陆";
            login.loginScuccsse = ^{
                
            };
            [self presentViewController:navc animated:YES completion:nil];
            
            return NO;
        }
        
    }
        return YES;
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
}



@end
