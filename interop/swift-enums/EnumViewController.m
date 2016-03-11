//
//  ViewController.m
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import "EnumViewController.h"
#import "interop-Swift.h"

@interface EnumViewController ()

@end

@implementation EnumViewController


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[SwiftVCViewController class]]) {
        
        SwiftVCViewController *swiftVCViewController
            = (SwiftVCViewController *)segue.destinationViewController;
        
        
        // Set IconView using image
        if ([segue.identifier isEqualToString:@"setIconViewWithImage"]){
        
            UIImage *image = [UIImage imageNamed:@"ic_motorcycle"];
            
            if(image != nil){
                swiftVCViewController.iconView = [[IconView alloc] initWithImage:image];
            }
        }
        
        // Set IconView using color
        if ([segue.identifier isEqualToString:@"setIconViewWithColor"]){
            
            swiftVCViewController.iconView = [[IconView alloc] initWithColor:[UIColor greenColor]];
        }
    }
}

@end
