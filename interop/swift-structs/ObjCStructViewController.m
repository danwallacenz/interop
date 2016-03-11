//
//  ObjCStructViewController.m
//  interop
//
//  Created by Daniel Wallace on 12/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import "ObjCStructViewController.h"
#import "interop-Swift.h"

@interface ObjCStructViewController ()

@property (strong,nonatomic) ProfileView *profileView;

@end

@implementation ObjCStructViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.profileView){
        UIView *myProfileView = self.profileView;
        
        [self.view addSubview: self.profileView];
        [self.view setBackgroundColor:[UIColor greenColor]];
//        [self.view setBackgroundColor:[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.5]];
       
        NSDictionary *views = NSDictionaryOfVariableBindings(myProfileView);
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[myProfileView]-(50)-|" options: 0 metrics:nil views:views]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(140)-[myProfileView]-(40)-|" options:0 metrics:nil views:views]];
    }
}

/**
 an example of creating a view in Objective-C which contains a Swift struct
*/
-(void)showProfileForUserWithName:(NSString *)name profileImageURL: (NSURL *)url {
    self.profileView = [[ProfileView alloc] initWithName:name profileImageURL: url.path];
}

@end
