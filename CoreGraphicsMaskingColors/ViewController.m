//
//  ViewController.m
//  CoreGraphicsMaskingColors
//
//  Created by Douglas Voss on 6/12/15.
//  Copyright (c) 2015 DougsApps. All rights reserved.
//

#import "ViewController.h"
#import "MaskImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MaskImage *maskView = [MaskImage new];
    maskView.frame = self.view.frame;
    [self.view addSubview:maskView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
