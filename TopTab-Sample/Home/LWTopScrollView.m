//
// Created by luowei on 15/9/30.
// Copyright (c) 2015 hardy. All rights reserved.
//

#import "LWTopScrollView.h"
#import "LWHomeDefines.h"
#import "LWContainerScrollView.h"
#import "UIImage+RCColor.h"
#import "LWHomeView.h"
#import "UIColor+CrossFade.h"

#define NormalColor [UIColor grayColor]
#define SelectedColor [UIColor blackColor]

@implementation LWTopScrollView {

    UIImageView *shadowImageView;           //按钮下的下划线

    NSArray<NSString *> *nameArray;        //标签数组
}

+ (instancetype)shareInstance {
    static LWTopScrollView *__singletion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __singletion = [[self alloc] initWithFrame:CGRectMake(0, TopWeatherView_H, MainHomeView_W, TopScrollView_H)];
    });
    return __singletion;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

        nameArray = Arr_ChannelNames;
//        nameArray = Arr_AduitingChannelNames;
//        nameArray = Arr_ChannelNames;

        _userSelectedChannelID = Tag_First_Channel;
        _scrollViewSelectedChannelID = Tag_First_Channel;

        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
        self.contentSize = CGSizeMake(TopBtn_W * nameArray.count, TopScrollView_H);

        
        //设置分类滚动条
        [self setupChannelBtns];
    }

//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aduitingChanged) name:NotifyTopView_AduitingChanged object:nil];

    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//审核状态发生变化
- (void)aduitingChanged {
    nameArray = Arr_ChannelNames;
    self.contentSize = CGSizeMake(TopBtn_W * nameArray.count, TopScrollView_H);

    //设置分类滚动条
    [self setupChannelBtns];
}

//更新子视图frame
- (void)layoutSubviews {
    [super layoutSubviews];

    self.frame = CGRectMake(0, TopWeatherView_H, MainHomeView_W, TopScrollView_H);
    self.contentSize = CGSizeMake(TopBtn_W * nameArray.count, TopScrollView_H);

    //更新标签按钮
    for (UIView *v in self.subviews) {
        if (v.tag >= Tag_First_Channel && v.tag <= Tag_First_Channel + [nameArray count] - 1) {
            v.frame = CGRectMake(0 + TopBtn_W * (v.tag - Tag_First_Channel), 0, TopBtn_W, self.frame.size.height);
        }
    }

    UIButton *button = (UIButton *) [self viewWithTag:_scrollViewSelectedChannelID];
    shadowImageView.frame = CGRectMake(0, 0, ShadowImage_W, ShadowImage_H);
    shadowImageView.center = CGPointMake(button.frame.origin.x + TopBtn_W / 2, self.frame.size.height - 2.5);
}

//设置顶行分类滚动条的按钮
- (void)setupChannelBtns {

    //设置标签
    for (int i = 0; i < [nameArray count]; i++) {

        UIButton *button = (UIButton *) [self viewWithTag:i + Tag_First_Channel];
        if (!button) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        [button setFrame:CGRectMake(TopBtn_W * i, 0, TopBtn_W, self.frame.size.height)];
        [button setTag:i + Tag_First_Channel];
        if (i == 0) {
            button.selected = YES;
        }
        [button setTitle:[NSString stringWithFormat:@"%@", nameArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(channelBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];

        //设置标签外观
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];

    }

    //标签阴影下划线
    if (!shadowImageView) {
        shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ShadowImage_W, ShadowImage_H)];
        [shadowImageView setImage:[UIImage imageWithColor:[UIColor blackColor] size:shadowImageView.frame.size]];
        [self addSubview:shadowImageView];
    }
    shadowImageView.center = CGPointMake(TopBtn_W / 2, self.frame.size.height - 5);
}

//选择一个标签
- (void)channelBtnTouchUpInside:(UIButton *)sender {
    if(!sender){
        return;
    }
    LWContainerScrollView *containerScrollView = [LWContainerScrollView shareInstance];

    //当处于编辑状态时，即containerScrollView的scrollEnable为No时,不能被选中
    if (!containerScrollView.scrollEnabled) {
        return;
    }

    [self adjustScrollViewContentX:sender];

    //如果更换按钮
    if (sender.tag != _userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *) [self viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;

        //赋值滑动列表选择标签Id
        _scrollViewSelectedChannelID = sender.tag;

        //设置内容页出现
        [containerScrollView showChannelWithChannelId:_scrollViewSelectedChannelID-Tag_First_Channel];
//        [containerScrollView setContentOffset:CGPointMake(ButtonId * MainHomeView_W, 0) animated:YES];
    }
}

//滑动标签以适应选择项,让选择项完全显示出来
- (void)adjustScrollViewContentX:(UIButton *)sender {
    if (sender.frame.origin.x - self.contentOffset.x > MainHomeView_W - TopBtn_W) {
        //4:表示显示五个标签
        [self setContentOffset:CGPointMake((ButtonId - Num_Btns_InAHomeWidth) * TopBtn_W, 0) animated:YES];
    }
    
    if (sender.frame.origin.x - self.contentOffset.x < 0) {
        [self setContentOffset:CGPointMake(ButtonId * TopBtn_W, 0) animated:YES];
    }
}

//滑动撤销选中按钮
- (void)setButtonUnSelect {
    UIButton *lastButton = (UIButton *) [self viewWithTag:_scrollViewSelectedChannelID];
    lastButton.selected = NO;
}

//滑动选中按钮
- (void)setButtonSelect {
    UIButton *button = (UIButton *) [self viewWithTag:_scrollViewSelectedChannelID];
    button.selected = YES;
    _userSelectedChannelID = button.tag;

    [UIView animateWithDuration:0.25 animations:^{
        shadowImageView.center = CGPointMake(button.frame.origin.x + TopBtn_W / 2, self.frame.size.height - 2.5);
    }];
    
}

//设置下划线的centerX
- (void)setShadowImageCenterX:(CGFloat)x {
    [UIView animateWithDuration:0.1 animations:^{
        shadowImageView.center = CGPointMake(x, self.frame.size.height - 2.5);
    } completion:^(BOOL finished) {
        if(finished){
            CGFloat shadowCenterX = shadowImageView.center.x;

            //给按钮设置过渡颜色
            for (int i = 0; i < [nameArray count]; i++) {
                UIButton *btn = (UIButton *) [self viewWithTag:i + Tag_First_Channel];
                if(!btn){
                    continue;
                }

                CGFloat btnCenterX = btn.center.x;
                CGFloat detaX = shadowCenterX-btnCenterX;
                CGFloat crossRatio = fabs(detaX/TopBtn_W);
                //下划线在按钮右边，还不到两个标签按钮中间时 或者 下划线在按钮左边，还不到两个标签按钮中间时
                if( (detaX > 0 && detaX < TopBtn_W) || (detaX > -TopBtn_W && detaX < 0) ){
                    btn.titleLabel.textColor = [UIColor colorForFadeBetweenFirstColor:SelectedColor secondColor:NormalColor atRatio:crossRatio];
                }
            }

        }
    }];

}


@end