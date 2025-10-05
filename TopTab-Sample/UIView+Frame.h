//
//  UIView+Frame.h
//
//  Created by imac on 7/16/13.
//  Copyright (c) 2013 imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

- (CGFloat)left;
- (CGFloat)right;
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)centerX;

- (void)setLeft:(CGFloat)left;
- (void)setBottom:(CGFloat)bottom;
- (void)setSize:(CGSize)size;
- (void)setTop:(CGFloat)top;
- (void)setWidth:(CGFloat)width;
- (void)setOrigin:(CGPoint)point;
- (void)setHeight:(CGFloat) height;
- (void)setCenterX:(CGFloat)x;
@end



@interface UIView(Rotation)

//用于接收屏幕发生旋转消息
- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation;

@end


@interface UIView (NoScrollToTop)

- (void)subViewNOScrollToTopExcludeClass:(Class)clazz;

@end

@interface UIView (Reload)

//递归向下更新子视图的数据
- (void)reloadSubViewData;

//重绘所有子视图中的UILabel
- (void)reRenderSubView;

@end