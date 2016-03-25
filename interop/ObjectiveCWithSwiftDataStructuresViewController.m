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


#pragma mark - Internal views containing Swift-only types.
@property (strong,nonatomic) ProfileView *profileView;
@property (strong,nonatomic) IconView *colorIconView;
@property (strong,nonatomic) IconView *imageIconView;


#pragma mark - Boxed<Swift-only-type> labels.
@property (weak, nonatomic) IBOutlet UILabel *boxedSwiftStructLabel;
@property (weak, nonatomic) IBOutlet UILabel *boxedSwiftEnumOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *boxedSwiftEnumTwoLabe;


#pragma mark - Layout container views.
@property (weak, nonatomic) IBOutlet UIView *topStructView;
@property (weak, nonatomic) IBOutlet UIView *topColorEnumView;
@property (weak, nonatomic) IBOutlet UIView *topImageEnumView;
@property (weak, nonatomic) IBOutlet UIView *bottomStructView;
@property (weak, nonatomic) IBOutlet UIView *bottomColorEnumView;
@property (weak, nonatomic) IBOutlet UIView *bottomImageEnumView;
@property (weak, nonatomic) IBOutlet UIView *boxedSwiftTypesLabelsContainer;


@end

@implementation ObjectiveCWithSwiftDataStructuresViewController


#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Swift Types in Objective-C"];
    
    [self layoutTopProfileView];
    [self layoutTopIconViewWithColor];
    [self layoutTopIconViewWithImage];
    
    [self.topStructView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.topStructView.layer setBorderWidth:1];
    [self.topColorEnumView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.topColorEnumView.layer setBorderWidth:1];
    [self.topImageEnumView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.topImageEnumView.layer setBorderWidth:1];
    
    [self.boxedSwiftTypesLabelsContainer.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.boxedSwiftTypesLabelsContainer.layer setBorderWidth:1];
    
    [self.boxedSwiftStructLabel setText: [NSString stringWithFormat:@"self._user = %@", self._user]];
    [self.boxedSwiftEnumOneLabel setText: [NSString stringWithFormat:@"self._icon1 = %@", self._icon1]];
    [self.boxedSwiftEnumTwoLabe setText: [NSString stringWithFormat:@"self._icon2 = %@", self._icon2]];
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

        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[profileView]" options:0 metrics:nil views:views]];
    }
}

-(void) layoutTopIconViewWithColor {
    
    if (self.colorIconView && self.topColorEnumView){
        
        [self layoutIconView:self.colorIconView in: self.topColorEnumView];
    }
}

-(void) layoutIconView: (IconView *)iconView in: (UIView *)container {
    
    [iconView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [container setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [container addSubview:iconView];
    
    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:container
                                                                            attribute:NSLayoutAttributeCenterX
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:iconView
                                                                            attribute:NSLayoutAttributeCenterX
                                                                           multiplier:1
                                                                             constant:0];
    [container addConstraint:horizontalConstraint];
    
    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:container
                                                                            attribute:NSLayoutAttributeCenterY
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:iconView
                                                                            attribute:NSLayoutAttributeCenterY
                                                                           multiplier:1
                                                                             constant:0];
    [container addConstraint:verticalConstraint];
}

-(void) layoutTopIconViewWithImage {
    
    if (self.imageIconView && self.topImageEnumView){
        
        [self layoutIconView:self.imageIconView in: self.topImageEnumView];
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
