//
//  MainObjCViewController.m
//  interop
//
//  Created by Daniel Wallace on 13/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import "MainObjCViewController.h"
#import "interop-Swift.h"

@interface MainObjCViewController ()

@end

@implementation MainObjCViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor greenColor]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.destinationViewController isKindOfClass:[SwiftStructViewController class]]) {
        
        SwiftStructViewController *swiftStructViewController
        = (SwiftStructViewController *)segue.destinationViewController;
        
        if ([segue.identifier isEqualToString:@"showStructVC"]){
            swiftStructViewController.profileView = [[ProfileView alloc] initWithName:@"Jim" profileImageURL:@"www.stuff.co.nz"];
        }
    }
}


@end
