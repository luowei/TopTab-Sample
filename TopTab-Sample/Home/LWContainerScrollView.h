//
// Created by luowei on 15/9/30.
// Copyright (c) 2015 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWDDDView.h"
#import "LWAAAView.h"

@class LWBBBView;
@class LWCCCView;
@class LWEEEView;
@class LWEEEView;


@interface LWContainerScrollView : UIScrollView <UIScrollViewDelegate>{
    CGFloat userContentOffsetX;
    BOOL isLeftScroll;
}

//@property(nonatomic, strong) RCGridScrollViewLayout *gridViewFlowLayout;

//首页
@property(nonatomic, strong) LWAAAView *firstPageView;

//新闻
@property(nonatomic, strong) LWBBBView *hotnewsView;

//影视
@property(nonatomic, strong) LWCCCView *movieView;

//小说
@property(nonatomic, strong) LWDDDView *bookshelfView;

//应用
@property(nonatomic, strong) LWEEEView *gridView;

@property(nonatomic, assign) NSInteger currentChannel;

//子视图ScrollView的scrollsToTop是否可用
@property(nonatomic) BOOL scrollTopEnable;

//天气上拉隐藏
@property(nonatomic) BOOL weatherPullUpHidden;

+ (instancetype)shareInstance;


//天气动画
- (void)verticelWeatherAnimationWithScrollView:(UIScrollView *)scrollView;

//根据指定的标签Id显示标签内容
-(void)showChannelWithChannelId:(NSInteger)channelId;

//更新contentOffset
- (void)updateContainerContentOffset;

@end

