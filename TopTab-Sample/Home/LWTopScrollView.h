//
// Created by luowei on 15/9/30.
// Copyright (c) 2015 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LWTopScrollView : UIScrollView{
}

//点击按钮选择名字ID
@property(nonatomic, assign) NSInteger userSelectedChannelID;
//滑动列表选择名字ID
@property(nonatomic, assign) NSInteger scrollViewSelectedChannelID;

+ (instancetype)shareInstance;

//选择一个标签
- (void)channelBtnTouchUpInside:(UIButton *)sender;

//滑动撤销选中按钮
- (void)setButtonUnSelect;

//滑动选中按钮
- (void)setButtonSelect;

//设置下划线的centerX
-(void)setShadowImageCenterX:(CGFloat)x;

@end