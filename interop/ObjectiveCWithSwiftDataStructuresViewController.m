//
//  ObjectiveCWithSwiftDataStructuresViewController.m
//  interop
//
//  Created by Daniel Wallace on 24/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import "ObjectiveCWithSwiftDataStructuresViewController.h"
#import "interop-Swift.h"

@interface ObjectiveCWithSwiftDataStructuresViewController ()

@property (strong,nonatomic) ProfileView *profileView;

@end

@implementation ObjectiveCWithSwiftDataStructuresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self._user){
        NSLog(@"self._user = %@", self._user);
    }
    if (self._icon1){
        NSLog(@"self._icon1 = %@", self._icon1);
    }
    if (self._icon2){
        NSLog(@"self._icon2 = %@", self._icon2);
    }
}


/**
 an example of creating a view in Objective-C which contains a Swift struct
 */
-(void)showProfileForUserWithName:(NSString *)name profileImageURL: (NSURL *)url {
    
    self.profileView = [[ProfileView alloc] initWithName:name profileImageURL: url];
    
    [self.profileView setTranslatesAutoresizingMaskIntoConstraints:false];
    
    [self.view addSubview: self.profileView];
    
    id topLayoutGuide = self.topLayoutGuide;
    
    UIView *myProfileView = self.profileView;
    NSDictionary *views = NSDictionaryOfVariableBindings(myProfileView, topLayoutGuide);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[myProfileView]-(50)-|" options: 0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-[myProfileView]" options:0 metrics:nil views:views]];
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
