//
//  OrderFooterView.m
//  JSzulin
//
//  Created by 王洋 on 2019/8/19.
//  Copyright © 2019年 yyy. All rights reserved.
//

#import "OrderFooterView.h"

@implementation OrderFooterView

+(instancetype)loadWithXib{
    OrderFooterView * view = [[[NSBundle mainBundle] loadNibNamed:@"OrderFooterView" owner:nil options:nil] lastObject];
    view.btn.layer.masksToBounds = YES;
    view.btn.layer.cornerRadius = 8;
    return view;
}

- (IBAction)AllBtn:(id)sender {
    if (_allBtnPrice) {
        _allBtnPrice();
    }
}


@end
