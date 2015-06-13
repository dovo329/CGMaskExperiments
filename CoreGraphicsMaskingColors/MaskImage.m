//
//  MaskImage.m
//  CoreGraphicsMaskingColors
//
//  Created by Douglas Voss on 6/12/15.
//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import "MaskImage.h"

@implementation MaskImage

//  Created by Shilo White on 10/16/11.
//  Copyright 2011 Shilocity Productions. All rights reserved.

#define COLOR_PART_RED(color)    (((color) >> 16) & 0xff)
#define COLOR_PART_GREEN(color)  (((color) >>  8) & 0xff)
#define COLOR_PART_BLUE(color)   ( (color)        & 0xff)

- (UIImage *)imageByReplacingColorsWithMinColor:(uint)minColor maxColor:(uint)maxColor withColor:(uint)newColor image:(UIImage *)img
{
    CGImageRef imageRef = img.CGImage;
    float width = CGImageGetWidth(imageRef);
    float height = CGImageGetHeight(imageRef);
    CGRect bounds = CGRectMake(0, 0, width, height);
    uint minRed = COLOR_PART_RED(minColor);
    uint minGreen = COLOR_PART_GREEN(minColor);
    uint minBlue = COLOR_PART_BLUE(minColor);
    uint maxRed = COLOR_PART_RED(maxColor);
    uint maxGreen = COLOR_PART_GREEN(maxColor);
    uint maxBlue = COLOR_PART_BLUE(maxColor);
    float newRed = COLOR_PART_RED(newColor)/255.0f;
    float newGreen = COLOR_PART_GREEN(newColor)/255.0f;
    float newBlue = COLOR_PART_BLUE(newColor)/255.0f;
    
    CGContextRef context = nil;
    
        context = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), CGImageGetColorSpace(imageRef), CGImageGetBitmapInfo(imageRef));
        CGContextSetRGBFillColor(context, newRed, newGreen, newBlue, 1.0);
        CGContextFillRect(context, bounds);

    float maskingColors[6] = {minRed, maxRed, minGreen, maxGreen, minBlue, maxBlue};
    CGImageRef maskedImageRef = CGImageCreateWithMaskingColors(imageRef, maskingColors);
    if (!maskedImageRef) return nil;
    CGContextDrawImage(context, bounds, maskedImageRef);
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    if (context) CGContextRelease(context);
    if (newImageRef != maskedImageRef) CGImageRelease(maskedImageRef);
    
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

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
    
    //CGContextDrawImage (context, rect, maskedImg);
    //CGContextDrawImage (context, rect, inputImage.CGImage);
    
    UIImage *maskTestImg = [self imageByReplacingColorsWithMinColor:0xffff0000 maxColor:0xffff0000 withColor:0xff00ff00 image:inputImage];
    UIImage *maskTestImg2 = [self imageByReplacingColorsWithMinColor:0xff0000ff maxColor:0xff0000ff withColor:0xff808080 image:maskTestImg];
    CGContextDrawImage (context, rect, maskTestImg2.CGImage);
    
}

@end
