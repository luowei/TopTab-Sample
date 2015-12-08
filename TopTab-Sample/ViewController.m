//
//  ViewController.m
//  TopTab-Sample
//
//  Created by luowei on 15/9/30.
//  Copyright © 2015年 wodedata. All rights reserved.
//

#import "ViewController.h"
#import "LWHomeView.h"
#import "LWHomeDefines.h"
#import "UIView+Frame.h"
#import "LWSuperScrollView.h"
#import "LWSubScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0,20,self.view.bounds.size.width,self.view.bounds.size.height)];
    _mainView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _mainView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_mainView];


    self.mainHomeView = [LWHomeView defaultHomeView];
    [_mainView addSubview:_mainHomeView];


//    LWSuperScrollView *superScrollView = [[LWSuperScrollView alloc] initWithFrame:CGRectMake(0,0,_mainView.frame.size.width,_mainView.frame.size.height)];
//    [_mainView addSubview:superScrollView];
//    superScrollView.backgroundColor = [UIColor whiteColor];
//
//    LWSubScrollView *subScrollView = [[LWSubScrollView alloc] initWithFrame:CGRectMake(50,50,_mainView.frame.size.width-100,_mainView.frame.size.height - 100)];
//    [superScrollView addSubview:subScrollView];
//    subScrollView.tag = 1000;
//    subScrollView.backgroundColor = [UIColor grayColor];

}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];

//    self.view.frame =
    _mainView.frame = self.view.bounds;
    _mainHomeView.frame = Frame_MainHomeView;
    [_mainView rotationToInterfaceOrientation:toInterfaceOrientation];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _mainView.frame = self.view.bounds;;

    [_mainView layoutSubviews];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
