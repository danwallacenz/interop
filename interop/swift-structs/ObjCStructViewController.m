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

@property (strong,nonatomic) ProfileView *internalProfileView;

@end

@implementation ObjCStructViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor: [UIColor greenColor]];
    
    if(self.profileView){
        UIView *myProfileView = self.profileView;
        
        [self.view addSubview: self.profileView];
       
        NSDictionary *views = NSDictionaryOfVariableBindings(myProfileView);
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[myProfileView]-(50)-|" options: 0 metrics:nil views:views]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(140)-[myProfileView]" options:0 metrics:nil views:views]];
    }
    
    if (self._user){
        NSLog(@"self._user = %@", self._user);

        NSLog(@"Pause");
        
        BoxedUserReceiver *boxedUserReceiver = [[BoxedUserReceiver alloc] init];
        [boxedUserReceiver setUser:self._user];
    }
}

/**
 an example of creating a view in Objective-C which contains a Swift struct
*/
-(void)showProfileForUserWithName:(NSString *)name profileImageURL: (NSURL *)url {
    self.profileView = [[ProfileView alloc] initWithName:name profileImageURL: url.path];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[SwiftBoxedUserViewController class]]){
        SwiftBoxedUserViewController *swiftBoxedUserViewController
            = (SwiftBoxedUserViewController *)segue.destinationViewController;
        
        if ([segue.identifier isEqualToString:@"showSwiftBoxedUserViewController"]){
            [swiftBoxedUserViewController setUser:self._user];
        }
    }
}

@end










