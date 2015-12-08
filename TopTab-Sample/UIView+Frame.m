
#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)point
{
    CGRect frame = self.frame;
    frame.origin = point;
    self.frame = frame;
}

- (void) setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

@end


@implementation UIView(Rotation)

//递归的向子视图发送屏幕发生旋转了的消息
- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation{
    for(UIView *v in self.subviews){
        [v rotationToInterfaceOrientation:orientation];
    }
}

@end

@implementation UIView (NoScrollToTop)

- (void)subViewNOScrollToTopExcludeClass:(Class)clazz {

    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *) v;
            scrollView.scrollsToTop = clazz == nil ? NO : [v isKindOfClass:clazz];
        }
        [v subViewNOScrollToTopExcludeClass:clazz];
    }
}

@end

@implementation UIView (Reload)

//递归向下更新子视图的数据
- (void)reloadSubViewData{
    if(!self){
        return;
    }
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UICollectionView class]]) {
            UICollectionView *collectionView = (UICollectionView *) v;
            [collectionView reloadData];
        }else if ([v isKindOfClass:[UITableView class]]) {
            UITableView *tableView = (UITableView *) v;
            [tableView reloadData];
        }else{
            [v reloadSubViewData];
        }
    }
}

//重绘所有子视图中的UILabel
- (void)reRenderSubView{
    if(!self){
        return;
    }
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *) v;
            [label setNeedsDisplay];
        }else{
            [v reRenderSubView];
        }

    }
}

@end