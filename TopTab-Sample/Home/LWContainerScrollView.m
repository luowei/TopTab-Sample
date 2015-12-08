//
// Created by luowei on 15/9/30.
// Copyright (c) 2015 hardy. All rights reserved.
//

#import "LWContainerScrollView.h"
#import "LWHomeDefines.h"
#import "LWTopScrollView.h"
#import "LWEEEView.h"

#import "LWCCCView.h"
#import "LWHomeView.h"
#import "LWAAAView.h"
#import "LWBBBView.h"
#import "LWHomeBGView.h"
#import "UIView+Frame.h"

//标签位置id
#define PositionId ((int)scrollView.contentOffset.x/MainHomeView_W)

@interface LWContainerScrollView () <UIGestureRecognizerDelegate>

@end

@implementation LWContainerScrollView {
    NSArray *nameArray;        //标签数组
    CGPoint lastPanOffset;  //上次滑动的位置
}

+ (instancetype)shareInstance {
    static LWContainerScrollView *__singletion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singletion = [[self alloc] initWithFrame:CGRectMake(0, (CGFloat) (TopWeatherView_H + TopScrollView_H), MainHomeView_W,
                (CGFloat) (MainHomeView_H - TopScrollView_H))];
    });
    return __singletion;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self.contentMode = UIViewContentModeTopRight;
        self.clipsToBounds = NO;
        self.delegate = self;

        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;

        self.pagingEnabled = YES;
        self.userInteractionEnabled = YES;
        self.bounces = NO;
        self.scrollsToTop = NO;
        self.scrollTopEnable = YES;

        userContentOffsetX = 0;
        nameArray = Arr_ChannelNames;
//        nameArray = Arr_AduitingChannelNames;
//        nameArray = Arr_ChannelNames;

        //设置contenSize
        self.contentSize = CGSizeMake(frame.size.width * nameArray.count, frame.size.height);
    }

    [self setupSubViews];

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aduitingChanged) name:NotifyContainer_AduitingChanged object:nil];

    return self;
}

//审核状态发生变化
- (void)aduitingChanged {
    nameArray = Arr_ChannelNames;
    self.contentSize = CGSizeMake(self.frame.size.width * nameArray.count, self.frame.size.height);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//更新subview的scrollsToTop
- (void)updateSubViewsScrollsToTop {
/*
    //所有的子scrollView的scrollToTop设置为NO;
    [self subViewNOScrollToTopExcludeClass:nil];

    if (!self.scrollTopEnable) {
        return;
    }
    switch (_currentChannel) {
        case 0: {    //首页
            _firstPageView.mainTableView.scrollsToTop = YES;
            break;
        }
        case 1: {    //新闻
            _hotnewsView.scrollTopEnable = YES;
            break;
        }
        case 2: {    //影视
            _movieView.mCollectionView.scrollsToTop = YES;
            break;
        }
        case 3: {    //小说
            _bookshelfView.bookshelfScrollView.scrollsToTop = YES;
            break;
        }
        case 4: {    //应用
            if (_gridView) {
                _gridView.scrollsToTop = YES;
            }
            break;
        }
        default:
            break;
    }
*/

}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];

}


- (void)layoutSubviews {
    [super layoutSubviews];

    self.frame = CGRectMake(0, TopWeatherView_H + TopScrollView_H, MainHomeView_W, MainHomeView_H - TopScrollView_H);

    //更新contentSize和content offset.x
    self.contentSize = CGSizeMake(self.frame.size.width * nameArray.count, self.frame.size.height);

    //更新Container下的子视图frame
    for (UIView *v in self.subviews) {
        if (v.tag >= Tag_First_Channel && v.tag <= Tag_First_Channel + [nameArray count] - 1) {
            v.frame = CGRectMake(0 + MainHomeView_W * (v.tag - Tag_First_Channel), 0, MainHomeView_W, self.frame.size.height);
        }
    }
}


//接收屏幕发生旋转消息
- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    //屏幕发生旋转修改contentOffset
    [self updateContainerContentOffset];
}

/*
//重新加载视图的数据
- (void)reloadSubViewData {
    NSInteger currentTag = [LWContainerScrollView shareInstance].currentChannel + Tag_First_Channel;
    UIView *v = [self viewWithTag:currentTag];
    if(v){
        [v reloadSubViewData];
    }
}
*/


//更新contentOffset
- (void)updateContainerContentOffset {
    NSUInteger selIdx = (NSUInteger) ([LWTopScrollView shareInstance].scrollViewSelectedChannelID - Tag_First_Channel);
    self.contentOffset = CGPointMake(selIdx * MainHomeView_W, 0);
}

//设置内容子视图
- (void)setupSubViews {
//    for (int i = 0; i < [nameArray count]; i++) {
    NSUInteger i = 0;
    CGRect contentFrame = CGRectMake(0 + MainHomeView_W * i, 0, MainHomeView_W, RootScrollView_H);

    if ([@"首页" isEqualToString:nameArray[i]]) {
        self.firstPageView = [[LWAAAView alloc] initWithFrame:contentFrame];
        _firstPageView.tag = Tag_First_Channel + i;
        [self addSubview:_firstPageView];

    }
    //注:这里要调set方法
    [self setCurrentChannel:i];
//    }
}


//滑动内容顶部滑动标签跟随滑动
- (void)adjustTopScrollViewButton:(UIScrollView *)scrollView {
    LWTopScrollView *topScrollView = [LWTopScrollView shareInstance];

    [topScrollView setButtonUnSelect];
    topScrollView.scrollViewSelectedChannelID = (NSInteger) (PositionId + Tag_First_Channel);;
    [topScrollView setButtonSelect];
}


#pragma mark - UIScrollViewDelegate 的实现

//开发滑动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    userContentOffsetX = scrollView.contentOffset.x;
}

//当滑动时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    //如果是上下滚动
    CGPoint offset = scrollView.contentOffset;
    if (fabs(offset.x) < fabs(offset.y)) {
        return;
    }

    isLeftScroll = userContentOffsetX < scrollView.contentOffset.x;

    //设置TopScrollView下划线的centerX
    LWTopScrollView *topScrollView = [LWTopScrollView shareInstance];
    [topScrollView setShadowImageCenterX:(TopBtn_W / 2 + scrollView.contentOffset.x * (TopBtn_W / self.frame.size.width))];

    //触发水平滑动的天气动画
    [self horizonWeatherAnimationWithScrollView:scrollView.contentOffset.x];

}

//当滑动结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    NSInteger i = (NSUInteger) roundf(scrollView.contentOffset.x / MainHomeView_W);
    [self setupCurrentChannel:i];

    //调整顶部滑条按钮状态
    [self adjustTopScrollViewButton:scrollView];

    [self adjustTopScrollView:scrollView];
}

//适应TopScrollView
- (void)adjustTopScrollView:(UIScrollView *)scrollView {
    LWTopScrollView *topScrollView = [LWTopScrollView shareInstance];
    //左滑
    if (isLeftScroll) {
        if (scrollView.contentOffset.x <= MainHomeView_W * (Num_Btns_InAHomeWidth - 1)) {
            [topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        } else {
            CGFloat topOffsetX = (topScrollView.contentOffset.x + TopBtn_W) > (nameArray.count - Num_Btns_InAHomeWidth) * TopBtn_W ?
                    topScrollView.contentOffset.x : topScrollView.contentOffset.x + TopBtn_W;
            [topScrollView setContentOffset:CGPointMake(topOffsetX, 0) animated:YES];
        }

    }
        //右滑
    else {
        if (scrollView.contentOffset.x >= MainHomeView_W * Num_Btns_InAHomeWidth) {
            CGFloat topOffsetX = topScrollView.contentOffset.x - TopBtn_W;
            [topScrollView setContentOffset:CGPointMake(topOffsetX, 0) animated:YES];
        }
        else {
            [topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}


#pragma mark - 显示标签内容

//根据指定的标签Id显示标签内容
-(void)showChannelWithChannelId:(NSInteger)channelId{
    
/*
    switch (channelId) {
        case 0:
            [MobClick event:EVENT_FirstPageTabClick label:@"首页"];
            break;
        case 1:
            [MobClick event:EVENT_FirstPageTabClick label:@"新闻"];
            break;
        case 2:
            [MobClick event:EVENT_FirstPageTabClick label:@"影视"];
            break;
        case 3:
            [MobClick event:EVENT_FirstPageTabClick label:@"小说"];
            break;
        case 4:
            [MobClick event:EVENT_FirstPageTabClick label:@"应用"];
            break;
            
        default:
            break;
    }
*/

    //设置TopScrollView下划线的centerX
    LWTopScrollView *topScrollView = [LWTopScrollView shareInstance];
    [topScrollView setShadowImageCenterX:(TopBtn_W / 2 + channelId * MainHomeView_W * (TopBtn_W / self.frame.size.width))];

    //触发水平滑动的天气动画
    [self horizonWeatherAnimationWithScrollView:channelId * MainHomeView_W];

    [self setupCurrentChannel:channelId];
    [self setContentOffset:CGPointMake(channelId * MainHomeView_W,0) animated:NO];
}

//设置当前选中栏目
- (void)setupCurrentChannel:(NSInteger)channelId {
    //滑动时创建内容详情页面
    CGRect contentFrame = CGRectMake(0 + MainHomeView_W * channelId, 0, MainHomeView_W, (CGFloat) (MainHomeView_H - TopScrollView_H));
    switch (channelId) {
        case 0: {    //首页
            self.scrollTopEnable = YES;


            break;
        }
        case 1: {    //新闻
            if (!self.hotnewsView) {
                self.hotnewsView = [[LWBBBView alloc] initWithFrame:contentFrame];
                _hotnewsView.tag = Tag_First_Channel + channelId;
                [self addSubview:_hotnewsView];
            }
            self.scrollTopEnable = YES;
            break;
        }
        case 2: {    //影视
            if (!self.movieView) {
                self.movieView = [[LWCCCView alloc] initWithFrame:contentFrame];
                _movieView.tag = Tag_First_Channel + channelId;
                [self addSubview:_movieView];
            }
            self.scrollTopEnable = YES;
            break;
        }
        case 3: {    //小说
            if (!self.bookshelfView) {
                self.bookshelfView = [[LWDDDView alloc] initWithFrame:contentFrame];
                _bookshelfView.tag = Tag_First_Channel + channelId;
                [self addSubview:_bookshelfView];
            }
            self.scrollTopEnable = YES;
            break;
        }
        case 4: {    //应用
            if (!self.gridView) {
                //构建应用宫格布局方法
//                RCGridScrollViewLayout *_gridViewFlowLayout = [[RCGridScrollViewLayout alloc] init];
                self.gridView = [[LWEEEView alloc] initWithFrame:contentFrame];
                _gridView.tag = Tag_First_Channel + channelId;
                [self addSubview:_gridView];
            }
//            else{
//                [_gridView reloadData];
//            }
            self.scrollTopEnable = YES;
            break;
        }
        default: {
            break;
        }
    }

    //设置_currentChannel，注:这里要调set方法
    _currentChannel = channelId < 0 ? 0 : (channelId > nameArray.count - 1 ? 4 : channelId);

    //更子视图的scrollsToTop
    [self updateSubViewsScrollsToTop];

    //保存
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:_currentChannel forKey:Key_CurrentChannel];
    [userDefaults synchronize];
}

//水平滑动的天气动画
- (void)horizonWeatherAnimationWithScrollView:(CGFloat)offSetX {
    LWHomeBGView *homeBGView = (LWHomeBGView *) self.superview;
    LWHomeView *homeView = (LWHomeView *) homeBGView.superview;

/*
    //天气动画,水平滑动、天气非隐藏时执行
    if (!_weatherPullUpHidden) {
        if (offSetX < self.frame.size.width) {
            [UIView animateWithDuration:0.25 animations:^{
                homeBGView.top = -offSetX / self.frame.size.width * TopWeatherView_H;
            }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                homeBGView.top = -TopWeatherView_H;
            }];
        }
    }
*/
    //天气动画,水平滑动、天气非隐藏时执行
    if (!_weatherPullUpHidden) {

        if (offSetX < self.frame.size.width) {

            CGFloat detaY = -offSetX / self.frame.size.width * TopWeatherView_H;
            [UIView animateWithDuration:0.25 animations:^{
                if(detaY <= homeView.topView.top){
                    homeBGView.top = detaY;
                    homeView.topView.top = 0;
                    [_firstPageView.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
                }
            }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                homeBGView.top = -TopWeatherView_H;
                homeView.topView.top = 0;
                [_firstPageView.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
            }];
        }

        //如果天气未隐藏,并且滑到了首页
        if (offSetX <= 0) {
            [_firstPageView.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }

}

//垂直滑动的天气动画
- (void)verticelWeatherAnimationWithScrollView:(UIScrollView *)scrollView {
    if(_currentChannel > 0){
        return;
    }

    CGFloat offSetY = scrollView.contentOffset.y;
    LWHomeBGView *homeBGView = (LWHomeBGView *) self.superview;
    LWHomeView *homeView = (LWHomeView *) homeBGView.superview;

/*
    //隐藏天气
    if (offSetY >= TopWeatherView_H) {
        _weatherPullUpHidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            homeBGView.top = -TopWeatherView_H;
        }];

        //显示天气
    } else {
        _weatherPullUpHidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
            homeBGView.top = offSetY < 0 ? 0 : -offSetY;
        }];
    }
*/

    //隐藏显示天气

    //上滑,天气处理显示状态,才支持上滑处理
    if (!_weatherPullUpHidden) {

        //如果上滑距离超过天气高度,天气设置成隐藏
        if (offSetY >= TopWeatherView_H) {

            homeBGView.top = -TopWeatherView_H;
            homeView.topView.top = 0;
//            self.top = TopWeatherView_H + TopScrollView_H;
            [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            _weatherPullUpHidden = YES;

        } else if (offSetY >= 0 && offSetY < TopWeatherView_H) {
            homeView.topView.top = -offSetY;
//            self.top = TopWeatherView_H + TopScrollView_H;
            _weatherPullUpHidden = NO;

            //解决快速下滑,篮色区域跟不上的问题
        } else {
            [UIView animateWithDuration:0.15 delay:0 usingSpringWithDamping:5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                homeBGView.top = 0;
                homeView.topView.top = 0;
            }                completion:nil];
            _weatherPullUpHidden = NO;
        }

    }

    //下拉,天气处于隐藏状态,才支持下拉处理
    if (_weatherPullUpHidden) {
        if (offSetY < 0) {
            homeBGView.top = 0;
            homeView.topView.top = -TopWeatherView_H;
//            self.top = TopWeatherView_H + TopScrollView_H;
            [scrollView setContentOffset:CGPointMake(0, TopWeatherView_H) animated:NO];
            _weatherPullUpHidden = NO;

        }

    }
}

//对.语法的读写方法重载，设置当前频道
- (void)setCurrentChannel:(NSInteger)currentChannel {

    //如果设置的Channel与当前显示的不同，显示设置的
    if (_currentChannel != currentChannel) {

        LWTopScrollView *topScrollView = [LWTopScrollView shareInstance];

        //做选中一个标签的操作
        topScrollView.scrollViewSelectedChannelID = (NSInteger) (currentChannel + Tag_First_Channel);
        UIButton *button = (UIButton *) [topScrollView viewWithTag:(NSInteger) (currentChannel + Tag_First_Channel)];
        if(!button){
            return;
        }
        [topScrollView channelBtnTouchUpInside:button];

        //适配TopScrollView的位置
        [self adjustTopScrollView:self];
    }
    _currentChannel = currentChannel;

    //更子视图的scrollsToTop
    [self updateSubViewsScrollsToTop];

    //保存
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:_currentChannel forKey:Key_CurrentChannel];
    [userDefaults synchronize];
}


@end

