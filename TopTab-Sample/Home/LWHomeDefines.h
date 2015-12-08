//
//  RCHomeDefines.h.h
//  TopTab-Sample
//
//  Created by luowei on 15/10/8.
//  Copyright (c) 2015 hardy. All rights reserved.
//

#ifndef ContainerVC_Demo_RCHomeDefines_h
#define ContainerVC_Demo_RCHomeDefines_h

#define kSearchbarHeight 44.0
#define kToolbarHeight 44.0
#define kTabbarHeight 44.0
#define kEditToolbarHeight 44.0
#define kStatusbarHeight 20.0
#define kTopPadding ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0 ?kStatusbarHeight:0)

//MainHomeView的高度、frame
#define MainHomeView_W [UIScreen mainScreen].bounds.size.width
#define MainHomeView_H  ((CGFloat)([UIScreen mainScreen].bounds.size.height - kToolbarHeight - kStatusbarHeight))
#define Frame_MainHomeView CGRectMake(0, kStatusbarHeight, MainHomeView_W, MainHomeView_H)

//第1个Channel的Tag,即首页的Tag
#define Tag_First_Channel 100

//一个屏幕宽度下显示5个标签
#define Num_Btns_InAHomeWidth 5


//顶部天气占位视图高度
#define TopWeatherView_H 54.0
//顶部分类滑条高度
#define TopScrollView_H 34.0
//分类内容视图高度
#define RootScrollView_H ((CGFloat)(MainHomeView_H - TopWeatherView_H - TopScrollView_H))

//顶部标签按钮宽度
#define TopBtn_W (MainHomeView_W / Num_Btns_InAHomeWidth)
//顶部标签阴影图片宽度
#define ShadowImage_W 38.0
//顶部标签阴影图片高度
#define ShadowImage_H 3.0


#define ButtonId (sender.tag-Tag_First_Channel)

#define Arr_ChannelNames @[@"首页", @"相册", @"视频", @"音乐", @"日志"]

//当前频道
#define Key_CurrentChannel @"Key_CurrentChannel"

#endif
