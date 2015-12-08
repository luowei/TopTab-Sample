//
//  UIImage+RCColor.h
//  TopTab-Sample
//
//  Created by imac on 15/3/25.
//  Copyright (c) 2015年 hardy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RCColor)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageByApplyingAlpha:(CGFloat )alpha  image:(UIImage*)image;

@end
