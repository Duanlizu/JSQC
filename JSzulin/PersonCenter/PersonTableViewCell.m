//
//  PersonTableViewCell.m
//  JSzulin
//
//  Created by 王洋 on 2019/8/18.
//  Copyright © 2019年 yyy. All rights reserved.
//

#import "PersonTableViewCell.h"

@implementation PersonTableViewCell

+ (instancetype) cellWithXibAndTableview:(UITableView *)tableview{
    
    PersonTableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:@"PersonTableViewCell"];
    
    if (nil==cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonTableViewCell" owner:nil options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
