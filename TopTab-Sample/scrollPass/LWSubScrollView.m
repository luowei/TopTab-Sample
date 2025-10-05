//
// Created by luowei on 15/12/2.
// Copyright (c) 2015 wodedata. All rights reserved.
//

#import "LWSubScrollView.h"
#import "LWSuperScrollView.h"


@implementation LWSubScrollView {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.contentSize = CGSizeMake(frame.size.width,frame.size.height*2);

        for (int i = 0; i*50 <= frame.size.height * 2; ++i) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20,i*50,200,40)];
            label.text = @"我是SubScrollView...";
            label.backgroundColor = [UIColor greenColor];
            [self addSubview:label];
        }

    }

    return self;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    LWSuperScrollView *superScrollView = (LWSuperScrollView *)self.superview;
    NSLog(@"======%f",superScrollView.contentOffset.y);
    if(superScrollView.contentOffset.y > 50){
        return self;
    }

    return self.superview;
//    return [super hitTest:point withEvent:event];

//    UIView *hitTestView = [super hitTest:point withEvent:event];
//    if (hitTestView == self) {
//        hitTestView = nil;
//    }
//    return hitTestView;
}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    LWSuperScrollView *superScrollView = (LWSuperScrollView *)self.superview;
//    if(superScrollView.contentOffset.y > 50){
//        [self hitTest:CGPointZero withEvent:nil];
//    }
//
//    [super touchesMoved:touches withEvent:event];
//}


@end