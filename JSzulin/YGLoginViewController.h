//
//  YGLoginViewController.h
//  YouGu
//
//  Created by mc1 on 2019/6/18.
//  Copyright © 2019 kou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^loginScuccsse)(void);

@interface YGLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wechatBotoom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bttop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeTop;

@property (nonatomic , copy)loginScuccsse loginScuccsse;

@property (nonatomic , assign)BOOL isLoginOut;
@end

NS_ASSUME_NONNULL_END
