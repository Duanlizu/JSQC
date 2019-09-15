//
//  OrderListCellTableViewCell.h
//  JSzulin
//
//  Created by 王洋 on 2019/8/18.
//  Copyright © 2019年 yyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DelectBtn)(NSDictionary * dic);

@interface OrderListCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *backview1;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *text1;
@property (weak, nonatomic) IBOutlet UILabel *text2;
@property (weak, nonatomic) IBOutlet UILabel *text3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;

@property (nonatomic , assign)BOOL HisAllPrice;

@property (nonatomic , strong)NSDictionary * dic;
@property (nonatomic , copy)DelectBtn DelectBtn;

+ (instancetype) cellWithXibAndTableview:(UITableView *)tableview;
@end
