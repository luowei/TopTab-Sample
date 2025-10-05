//
// Created by luowei on 15/11/17.
// Copyright (c) 2015 wodedata. All rights reserved.
//

#import "LWAAAView.h"
#import "LWContainerScrollView.h"
#import "UIView+Frame.h"
#import "LWHomeDefines.h"


@implementation LWAAAView {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.clipsToBounds = NO;
        
        self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor blueColor];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.clipsToBounds = NO;

        [self addSubview:self.tableView];
        
        //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }

    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"aaaaa__%d", indexPath.row];
    cell.textLabel.backgroundColor = [UIColor greenColor];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 100;
    }else{
        return  44;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    LWContainerScrollView *containerScrollView = [LWContainerScrollView shareInstance];
    [containerScrollView verticelWeatherAnimationWithScrollView:scrollView];
//    if (scrollView.contentOffset.y < 0)
//        containerScrollView.bottom = TopWeatherView_H + MainHomeView_H - scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

}


@end