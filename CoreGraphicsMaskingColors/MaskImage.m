//
//  MaskImage.m
//  CoreGraphicsMaskingColors
//
//  Created by Douglas Voss on 6/12/15.
//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import "MaskImage.h"

@implementation MaskImage

// Many thanks to code from Shilo White for showing me how to cascade masks
// https://gist.github.com/Shilo/1292152

- (CGImageRef)cgImageReplaceColor:(uint)color newColor:(uint)newColor cgImg:(CGImageRef)cgImg
{
    int width = CGImageGetWidth(cgImg);
    int height = CGImageGetHeight(cgImg);
    CGRect bounds = CGRectMake(0,0,width,height);
    CGContextRef bmpContext = CGBitmapContextCreate(NULL, CGImageGetWidth(cgImg), CGImageGetHeight(cgImg), CGImageGetBitsPerComponent(cgImg), CGImageGetBytesPerRow(cgImg), CGImageGetColorSpace(cgImg), CGImageGetBitmapInfo(cgImg));
    uint red = ((color & 0x00ff0000) >> 16);
    uint green = ((color & 0x0000ff00) >> 8);
    uint blue = ((color & 0x000000ff) >> 0);
    uint newRed = ((newColor & 0x00ff0000) >> 16);
    uint newGreen = ((newColor & 0x0000ff00) >> 8);
    uint newBlue = ((newColor & 0x000000ff) >> 0);
    CGContextSetRGBFillColor(bmpContext, newRed, newGreen, newBlue, 1.0);
    CGContextFillRect(bmpContext, bounds);
    float maskColArr[6] = {red, red, green, green, blue, blue};
    CGImageRef maskedCGImg = CGImageCreateWithMaskingColors(cgImg, maskColArr);
    CGContextDrawImage(bmpContext, bounds, maskedCGImg);
    
    CGImageRef retCGImg = CGBitmapContextCreateImage(bmpContext);
    
    CGContextRelease(bmpContext);
    CGImageRelease(maskedCGImg);
    
    return retCGImg;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.newCol1 = 0xff00ffff;
        self.newCol2 = 0xff0000ff;
    }
    return self;
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIImage *inputImage = [UIImage imageNamed:@"TestColorShape"];
    
    CGImageRef cgImgMask1 = [self cgImageReplaceColor:0xffff0000 newColor:self.newCol1 cgImg:inputImage.CGImage];
    //CGContextDrawImage (context, rect, cgImgMask1);
    
    CGImageRef cgImgMask2 = [self cgImageReplaceColor:0xff0000ff newColor:self.newCol2 cgImg:cgImgMask1];

    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage (context, rect, cgImgMask2);
    
    CGImageRelease(cgImgMask1);
    CGImageRelease(cgImgMask2);
}

@end
