//
//  OrderListCellTableViewCell.m
//  JSzulin
//
//  Created by 王洋 on 2019/8/18.
//  Copyright © 2019年 yyy. All rights reserved.
//

#import "OrderListCellTableViewCell.h"

@implementation OrderListCellTableViewCell

+ (instancetype) cellWithXibAndTableview:(UITableView *)tableview{
    
    OrderListCellTableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:@"OrderListCellTableViewCell"];
    
    if (nil==cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderListCellTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.backView.layer.masksToBounds = YES;
    cell.backView.layer.cornerRadius = 8;
    
    cell.backview1.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.backview1.layer.shadowOffset = CGSizeMake(2, 1);
    cell.backview1.layer.shadowOpacity = 1;
    cell.backview1.layer.shadowRadius = 7.0;
    cell.backview1.layer.cornerRadius = 9.0;
    cell.backview1.clipsToBounds = NO;

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (IBAction)delectBtn:(id)sender {
    
    self.DelectBtn(_dic);
    
}

-(void)setDic:(NSDictionary *)dic{
    _dic = dic;
    self.text1.text = _dic[@"name"];
    self.text2.text = [NSString stringWithFormat:@"%@天",_dic[@"number"]];
    if (_HisAllPrice) {
        self.text3.text = [NSString stringWithFormat:@"总计:¥%lu",[_dic[@"price"] integerValue]*[_dic[@"number"]integerValue]];
    }else{
        self.text3.text = [NSString stringWithFormat:@"¥%lu",[_dic[@"price"] integerValue]*[_dic[@"number"]integerValue]];
    }
}


@end
