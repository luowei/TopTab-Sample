//
// Created by luowei on 15/11/9.
// Copyright (c) 2015 hardy. All rights reserved.
//

#import "LWHomeBGView.h"
#import "LWContainerScrollView.h"
#import "LWHomeDefines.h"


@implementation LWHomeBGView {
    CGFloat oldOffsetY;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor brownColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

//    LWContainerScrollView *containerScrollView = [LWContainerScrollView shareInstance];
//    if(!containerScrollView.weatherPullUpHidden){
//        self.frame = CGRectMake(0,0,self.frame.size.width,self.frame.size.height + TopWeatherView_H);
//    }

}



@end