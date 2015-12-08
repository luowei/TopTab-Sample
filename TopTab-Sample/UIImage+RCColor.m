//
//  UIImage+RCColor.m
//  TopTab-Sample
//
//  Created by imac on 15/3/25.
//  Copyright (c) 2015年 hardy. All rights reserved.
//

#import "UIImage+RCColor.h"

@implementation UIImage (RCColor)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
}

+(UIImage *)imageByApplyingAlpha:(CGFloat )alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
   
    UIGraphicsEndImageContext(); 
    
    
    return newImage;
    
}

@end
