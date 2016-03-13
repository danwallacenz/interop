//
//  OldStyleViewController.m
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import "OldStyleViewController.h"
#import "interop-Swift.h"

@interface OldStyleViewController ()

@property (strong, nonatomic) UIColor *background;

@end

@implementation OldStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor: [UIColor greenColor]];
    
    [self addBackgroundIcon];
    
    [self setTitle:@"Legacy Objective-C View Controller"];
    
    NSLog(@"\nIn Objective-C, Icon enum is %@", self._icon);
    
    NSLog(@"self.iconImage = %@", self.iconImage);
    NSLog(@"iconColor = %@", self.iconColor);

    NSLog(@"Pause");
}

- (void)addBackgroundIcon {
    if (self.background && self.view) {
        UIView *newView = [[UIView alloc] initWithFrame:[self iconFrame]];
        [newView setBackgroundColor:self.background];
        [self.view addSubview:newView];
    }
}

-(CGRect)iconFrame {
    return CGRectMake(0, 0, self.view.bounds.size.width/2, self.view.bounds.size.height/2);
}

/**
 implementation of shim to allow passing a Swift enum to an Objective-C class
 see OldStyleViewController.swift
 */
-(void)showIconViewWithColor:(UIColor *)color{
    self.background = color;
    [self addBackgroundIcon];
}

/**
 implementation of shim to allow passing a Swift enum to an Objective-C class
 see OldStyleViewController.swift
 */
-(void)showIconViewWithImage:(UIImage *)image {
    UIColor *backgroundImage = [[UIColor alloc] initWithPatternImage:image];
    self.background = backgroundImage;
    [self addBackgroundIcon];
}


@end
