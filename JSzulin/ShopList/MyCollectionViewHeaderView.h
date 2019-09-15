//
//  MyCollectionViewHeaderView.h
//  JSzulin
//
//  Created by 王洋 on 2019/8/18.
//  Copyright © 2019年 yyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidClickHot)(NSInteger tag);

@interface MyCollectionViewHeaderView : UICollectionReusableView


@property (weak, nonatomic) IBOutlet UIView *topView;

@property (nonatomic , copy)DidClickHot DidClickHot;

@end
