//
// Created by luowei on 15/9/30.
// Copyright (c) 2015 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWContainerScrollView.h"
#import "LWTopScrollView.h"

//@class LWTopScrollView;
//@class LWContainerScrollView;
@class LWEEEView;
@class LWHomeView;
@class LWHomeBGView;
@class LWTopHiddenView;
@class LWTopHiddenView;


@protocol  RCIndexViewDelegate <NSObject>

- (void) indexItemDidSelected:(NSString*) url;
- (void) indexSearchBarDidBeginEditing;
@end


@protocol LWHomeGestureDelegate <NSObject>

- (void)scrollViewDidScroll:(LWHomeView *)homeView;
- (void)scrollViewDidEndDragging:(LWHomeView *)homeView;
- (void)scrollViewDidEndDecelerating:(LWHomeView *)homeView;
@end



@interface LWHomeView : UIView

@property (nonatomic, assign) id<LWHomeGestureDelegate>homeGestureDelegate;


//顶部天气占位视图
@property(nonatomic, strong) LWTopHiddenView *topWeatherView;
//顶部分类滑条
@property(nonatomic, strong) LWTopScrollView *topScrollView;
//可左右滑动的容器视图
@property(nonatomic, strong) LWContainerScrollView *containerScroolView;


//应用
@property (nonatomic, strong) NSMutableArray *gridItems;
@property (nonatomic, strong) LWEEEView *gridScrollView;

@property(nonatomic, strong) UIView *topView;

@property(nonatomic, strong) LWHomeBGView *backgroundView;

//获得九宫格滚动视图
- (LWEEEView *)gridScrollView;

//获得homeView单例
+ (instancetype)defaultHomeView;

- (void)reloadGridData;


/*
//获得当前Channel
- (NSInteger)currentChannel;

//设置当前Channel(根据指定的频道Id,切换到指定频道上去,无动画效果)
- (void)setCurrentChannel:(NSInteger)currentChannel;

//选中一个频道(根据指定的频道Id,切换到指定频道上去,有动画效果)
-(void)selectChannelWithId:(NSInteger)channelId;
*/


@end
