//
// Created by luowei on 15/9/30.
// Copyright (c) 2015 hardy. All rights reserved.
//

#import "LWHomeView.h"
#import "LWTopScrollView.h"

#import "LWHomeDefines.h"
#import "LWEEEView.h"
#import "LWHomeBGView.h"
#import "LWTopHiddenView.h"
#import "UIView+Frame.h"

@interface LWHomeView () <UIGestureRecognizerDelegate> {

}
@property(nonatomic, strong) UIPanGestureRecognizer *panGesture;


@end

@implementation LWHomeView {

}

//获得homeView单例
+ (instancetype)defaultHomeView {
    static LWHomeView *_defaultHomeView = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _defaultHomeView = [[self alloc] initWithFrame:Frame_MainHomeView];
    });

    return _defaultHomeView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor whiteColor];

        //homeView的最底层视图
        self.backgroundView = [[LWHomeBGView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height)];
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_backgroundView];
    
        //滑动内容区域视图
        self.containerScroolView = [LWContainerScrollView shareInstance];
        [_backgroundView addSubview:self.containerScroolView];

        //topView包含topWeatherView与topScrollView
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0,0,frame.size.width, (CGFloat) (TopWeatherView_H+TopScrollView_H))];
        self.topView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_backgroundView addSubview:self.topView];
        [_backgroundView bringSubviewToFront:self.topView];

        //顶部天气占位视图
        self.topWeatherView = [[LWTopHiddenView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, TopWeatherView_H+2)];
        self.topWeatherView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        self.topWeatherView.backgroundColor = [UIColor blueColor];
        [self.topView addSubview:self.topWeatherView];

        //顶部分类滑条
        self.topScrollView = [LWTopScrollView shareInstance];
        [self.topView addSubview:self.topScrollView];
    
        [self reloadGridData];
        
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    //在首页标签,并且天气非隐藏状态时
    if (self.containerScroolView.currentChannel == 0 && !self.containerScroolView.weatherPullUpHidden) {
        _backgroundView.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height + TopWeatherView_H);
    } else {
        _backgroundView.frame = CGRectMake(0,  -(CGFloat)TopWeatherView_H,self.frame.size.width, self.frame.size.height + TopWeatherView_H);
    }

}

- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    //在所有子视图转屏前，先更新
    [self layoutIfNeeded];

    [super rotationToInterfaceOrientation:orientation];
}


//单例模式下,需调整frame,切换委托
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        self.frame = Frame_MainHomeView;
//        [self.containerScroolView resetSubViewDelegate:newSuperview];
    }
}

//添加约束
- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    //重新加入刷新子视图
    [self layoutIfNeeded];

}

- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];

    //更新子视图数据
    [self reloadSubViewData];

//    //重给所有子视图中的UILabel
//    [self reRenderSubView];
}


- (void)reloadGridData{
//    [self.gridScrollView reloadData];
}

- (id <LWHomeGestureDelegate>)homeGestureDelegate {
    return _homeGestureDelegate;
}

/*
//返回containerScroolView里的gridView
- (LWEEEView *)gridScrollView {
    return self.containerScroolView.gridView;
}

//获得当前Channel
- (NSInteger)currentChannel {
    return [[NSUserDefaults standardUserDefaults] integerForKey:Key_CurrentChannel];
}

//设置当前Channel((根据指定的频道Id,切换到指定频道上去,无动画效果))
- (void)setCurrentChannel:(NSInteger)currentChannel {
    [self.containerScroolView setCurrentChannel:currentChannel];
}

//选中一个频道(根据指定的频道Id,切换到指定频道上去,有动画效果)
-(void)selectChannelWithId:(NSInteger)channelId{

    LWTopScrollView *topScrollView = [LWTopScrollView shareInstance];
    UIButton *btn = (UIButton *) [topScrollView viewWithTag:Tag_First_Channel + channelId];
    if(btn==nil){
        return;
    }
    [topScrollView channelBtnTouchUpInside:btn];
}
*/

@end

