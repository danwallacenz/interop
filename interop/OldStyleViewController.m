//
//  OldStyleViewController.m
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import "OldStyleViewController.h"

@interface OldStyleViewController ()

@property (strong, nonatomic) UIColor *background;

@end

@implementation OldStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addBackgroundIcon];
//    if(self.background){
//        [self addBackgroundIcon];
//    }
//    if(self.background){
//        UIView *newView = [[UIView alloc] initWithFrame:self.view.frame];
//        [newView setBackgroundColor:self.background];
//        [self.view addSubview:newView];
//    }
}

- (void)addBackgroundIcon {
    if (self.background && self.view) {
        UIView *newView = [[UIView alloc] initWithFrame:self.view.frame];
        [newView setBackgroundColor:self.background];
        [self.view addSubview:newView];
    }
}

-(void)showIconViewWithColor:(UIColor *)color{
    self.background = color;
    [self addBackgroundIcon];
//    if(self.view){
//        self.view.backgroundColor = self.background;
//        [self.view setNeedsDisplay];
//    }
}

-(void)showIconViewWithImage:(UIImage *)image {
    UIColor *backgroundImage = [[UIColor alloc] initWithPatternImage:image];
    self.background = backgroundImage;
    [self addBackgroundIcon];
//    if(self.view){
//        self.view.backgroundColor = self.background;
//        [self.view setNeedsDisplay];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
