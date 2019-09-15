//
//  PersonTableViewCell.h
//  JSzulin
//
//  Created by 王洋 on 2019/8/18.
//  Copyright © 2019年 yyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UILabel *text1;


+ (instancetype) cellWithXibAndTableview:(UITableView *)tableview;
@end
