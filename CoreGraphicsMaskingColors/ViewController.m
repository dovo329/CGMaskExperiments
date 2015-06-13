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

@property (nonatomic, strong) MaskImage *maskView;
@property (nonatomic, assign) bool toggle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.toggle = true;
    self.maskView = [MaskImage new];
    self.maskView.frame = self.view.frame;
    [self.view addSubview:self.maskView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    if (self.toggle)
    {
        self.maskView.newCol1 = 0xff0000ff;
        self.maskView.newCol2 = 0xffff0000;
    } else {
        self.maskView.newCol1 = 0xffff0000;
        self.maskView.newCol2 = 0xff0000ff;
    }
    [self.maskView setNeedsDisplay];
    self.toggle = !self.toggle;
}

@end
