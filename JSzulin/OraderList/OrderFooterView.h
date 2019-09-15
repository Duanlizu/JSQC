//
//  OrderFooterView.h
//  JSzulin
//
//  Created by 王洋 on 2019/8/19.
//  Copyright © 2019年 yyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^allBtnPrice)(void);
@interface OrderFooterView : UIView
@property (nonatomic , copy)allBtnPrice allBtnPrice;

@property (weak, nonatomic) IBOutlet UIButton *btn;

+(instancetype)loadWithXib;

@end
