//
//  ViewController.m
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import "ViewController.h"
#import "interop-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[SwiftVCViewController class]]) {
        
        SwiftVCViewController *swiftVCViewController
            = (SwiftVCViewController *)segue.destinationViewController;
        
        if([segue.identifier isEqualToString: @"showImage"]){
            swiftVCViewController.showImage = YES;
        
        } else if ([segue.identifier isEqualToString: @"showColor"]){
            swiftVCViewController.showImage = NO;
        
            
            // Set IconView using image
        } else if ([segue.identifier isEqualToString:@"setIconViewWithImage"]){
            
            UIImage *image = [UIImage imageNamed:@"ic_motorcycle"];
            if(image != nil){
                swiftVCViewController.iconView = [[IconView alloc] initWithImage:image];
            }
        
            // Set IconView using color
        } else if ([segue.identifier isEqualToString:@"setIconViewWithColor"]){
            swiftVCViewController.iconView = [[IconView alloc] initWithColor:[UIColor greenColor]];
        }
    }
}

@end
