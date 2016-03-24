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

@property (strong,nonatomic) IconView *colorIconView;
@property (strong,nonatomic) IconView *imageIconView;


#pragma mark - Layout container views

@property (weak, nonatomic) IBOutlet UIView *topStructView;
@property (weak, nonatomic) IBOutlet UIView *topColorEnumView;
@property (weak, nonatomic) IBOutlet UIView *topImageEnumView;
@property (weak, nonatomic) IBOutlet UIView *bottomStructView;
@property (weak, nonatomic) IBOutlet UIView *bottomColorEnumView;
@property (weak, nonatomic) IBOutlet UIView *bottomImageEnumView;

@end

@implementation ObjectiveCWithSwiftDataStructuresViewController


#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutTopProfileView];
    [self layoutTopIconViewWithColor];
    [self layoutTopIconViewWithImage];
}


#pragma mark - Public view creation

/**
 an example of creating a view in Objective-C which contains a Swift struct
 */
-(void)showProfileForUserWithName:(NSString *)name profileImageURL: (NSURL *)url {
    
    self.profileView = [[ProfileView alloc] initWithName:name profileImageURL: url];
    [self layoutTopProfileView];
}

/**
 implementation of shim to allow passing a Swift enum to an Objective-C class
 see OldStyleViewController.swift
 */
-(void)showIconViewWithColor:(UIColor *)color{
    
    self.colorIconView = [[IconView alloc] initWithColor:color];
    [self layoutTopIconViewWithColor];
}

/**
 implementation of shim to allow passing a Swift enum to an Objective-C class
 see OldStyleViewController.swift
 */
-(void)showIconViewWithImage:(UIImage *)image {
    
    self.imageIconView = [[IconView alloc] initWithImage:image];
    [self layoutTopIconViewWithImage];
}


#pragma mark - View layout

- (void) layoutTopProfileView {
    
    if (self.profileView && self.topStructView){
    
        [self.profileView setTranslatesAutoresizingMaskIntoConstraints:false];
        [self.topStructView setTranslatesAutoresizingMaskIntoConstraints:false];
        
        [self.topStructView addSubview: self.profileView];

        NSDictionary *views = @{ @"profileView" : self.profileView};
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[profileView]-|" options: 0 metrics:nil views:views]];

        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[profileView]-|" options:0 metrics:nil views:views]];
    }
}

-(void) layoutTopIconViewWithColor {
    
    if (self.colorIconView && self.topColorEnumView){
        
        [self.colorIconView setTranslatesAutoresizingMaskIntoConstraints:false];
        [self.topColorEnumView setTranslatesAutoresizingMaskIntoConstraints:false];
        
        [self.topColorEnumView addSubview: self.colorIconView];

        NSDictionary *views = @{ @"colorIconView" : self.colorIconView };
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[colorIconView]-|" options: 0 metrics:nil views:views]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[colorIconView]-|" options:0 metrics:nil views:views]];
    }
}

-(void) layoutTopIconViewWithImage {
    
    if (self.imageIconView && self.topImageEnumView){
        
        [self.imageIconView setTranslatesAutoresizingMaskIntoConstraints:false];
        
        [self.topImageEnumView setTranslatesAutoresizingMaskIntoConstraints:false];
        
        [self.topImageEnumView addSubview: self.imageIconView];
        
        NSDictionary *views = @{ @"imageIconView" : self.imageIconView };
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageIconView]-|" options: 0 metrics:nil views:views]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageIconView]-|" options:0 metrics:nil views:views]];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
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

@end
