//
// Created by luowei on 15/12/2.
// Copyright (c) 2015 wodedata. All rights reserved.
//

#import "LWSuperScrollView.h"


@implementation LWSuperScrollView {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.contentSize = CGSizeMake(frame.size.width,frame.size.height + 100);

        for (int i = 0; i*50 <= frame.size.height + 100; ++i) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20,i*50,200,40)];
            label.text = @"我是SuperScrollView...";
            label.backgroundColor = [UIColor redColor];
            [self addSubview:label];
        }

    }

    return self;
}


/*
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    if(point.y > 50){
//        return [self viewWithTag:1000];
//    }
    return [super hitTest:point withEvent:event];

//    UIView *hitTestView = [super hitTest:point withEvent:event];
//    if (hitTestView) {
//        hitTestView = [self viewWithTag:1000];
//    }
//    return hitTestView;
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if(offsetY > 50){
//        [self hitTest:scrollView.contentOffset withEvent:nil];
//    }
}


@end