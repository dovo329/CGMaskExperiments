//
//  MaskImage.m
//  CoreGraphicsMaskingColors
//
//  Created by Douglas Voss on 6/12/15.
//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import "MaskImage.h"

@implementation MaskImage

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //UIImage *inputImage = [UIImage imageNamed:@"egg_drop"];
    UIImage *inputImage = [UIImage imageNamed:@"TestColorShape"];
    //const float colorMasking[6]={100.0, 255.0, 0.0, 100.0, 100.0, 255.0};
    //const CGFloat colorMasking[6]={254.0, 254.0, 254.0, 255.0, 255.0, 255.0};
    //const CGFloat colorMasking[6]={100.0, 255.0, 100.0, 255.0, 100.0, 255.0};
    const CGFloat colorMasking[6]={255.0, 255.0, 0.0, 0.0, 0.0, 0.0};
    CGImageRef maskedImg = CGImageCreateWithMaskingColors(inputImage.CGImage, colorMasking);
    CGContextSetRGBFillColor(context, 255.0, 255.0, 0.0, 1.0);
    CGContextFillRect(context, rect);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage (context, rect, maskedImg);
    //CGContextDrawImage (context, rect, inputImage.CGImage);
}

@end
