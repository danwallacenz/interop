//
//  LegacyViewController.m
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import "LegacyViewController.h"

@interface LegacyViewController ()

@property (strong, nonatomic) UIColor *background;

@end

@implementation LegacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.background){
        self.view.backgroundColor = self.background;
    }
}

-(void)showIconViewWithColor:(UIColor *)color{
    self.background = color;
    if(self.view){
        [self.view setNeedsDisplay];
    }
}

-(void)showIconViewWithImage:(UIImage *)image {
    UIColor *backgroundImage = [[UIColor alloc] initWithPatternImage:image];
    self.background = backgroundImage;
    if(self.view){
        [self.view setNeedsDisplay];
    }
}

@end
