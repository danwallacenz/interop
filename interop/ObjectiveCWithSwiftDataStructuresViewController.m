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
    
    [self layoutTopProfileViewIfPossible];
    [self layoutTopIconViewWithColorIfPossible];
    [self layoutTopIconViewWithImageIfPossible];
    
    // Boxed labels
    [self.boxedSwiftStructLabel setText: [NSString stringWithFormat:@"self._user = %@", self._user]];
    [self.boxedSwiftEnumOneLabel setText: [NSString stringWithFormat:@"self._colorIcon = %@", self._colorIcon]];
    [self.boxedSwiftEnumTwoLabe setText: [NSString stringWithFormat:@"self._imageIcon = %@", self._imageIcon]];
    
    [self layoutExternalProfileViewIfPossible];
    [self layoutExternalColorIconViewIfPossible];
    [self layoutExternalImageIconViewIfPossible];
    
    [self addBorders];
}

-(void) layoutExternalProfileViewIfPossible {
   
    if (self.externalProfileView && self.bottomStructView){
        
        [self.externalProfileView setTranslatesAutoresizingMaskIntoConstraints:false];
        [self.bottomStructView setTranslatesAutoresizingMaskIntoConstraints:false];
        
        [self.bottomStructView addSubview: self.externalProfileView];
        
        NSDictionary *views = @{ @"externalProfileView" : self.externalProfileView};
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[externalProfileView]-|" options: 0 metrics:nil views:views]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[externalProfileView]" options:0 metrics:nil views:views]];
    }
}

-(void) layoutExternalColorIconViewIfPossible {
    
    if (self.externalColorIconView && self.bottomColorEnumView){
        [self layoutIconView:self.externalColorIconView in: self.bottomColorEnumView];
    }
}

-(void) layoutExternalImageIconViewIfPossible {
    
    if (self.externalImageIconView && self.bottomImageEnumView){
        [self layoutIconView:self.externalImageIconView in: self.bottomImageEnumView];
    }
}


#pragma mark - Public view creation

/**
 an example of creating a view in Objective-C which contains a Swift struct
 */
-(void)showProfileForUserWithName:(NSString *)name profileImageURL: (NSURL *)url {
    
    self.profileView = [[ProfileView alloc] initWithName:name profileImageURL: url];

    [self layoutTopProfileViewIfPossible];
}

/**
 implementation of shim to allow passing a Swift enum to an Objective-C class
 see OldStyleViewController.swift
 */
-(void)showIconViewWithColor:(UIColor *)color{
    
    self.colorIconView = [[IconView alloc] initWithColor:color];
    [self layoutTopIconViewWithColorIfPossible];
}

/**
 implementation of shim to allow passing a Swift enum to an Objective-C class
 see OldStyleViewController.swift
 */
-(void)showIconViewWithImage:(UIImage *)image {
    
    self.imageIconView = [[IconView alloc] initWithImage:image];
    [self layoutTopIconViewWithImageIfPossible];
}


#pragma mark - View layout

- (void) layoutTopProfileViewIfPossible {
    
    if (self.profileView && self.topStructView){
    
        [self.profileView setTranslatesAutoresizingMaskIntoConstraints:false];
        [self.topStructView setTranslatesAutoresizingMaskIntoConstraints:false];
        
        [self.topStructView addSubview: self.profileView];

        NSDictionary *views = @{ @"profileView" : self.profileView};
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[profileView]-|" options: 0 metrics:nil views:views]];

        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[profileView]" options:0 metrics:nil views:views]];
    }
}

-(void) layoutTopIconViewWithColorIfPossible {
    
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

-(void) layoutTopIconViewWithImageIfPossible {
    
    if (self.imageIconView && self.topImageEnumView){
        
        [self layoutIconView:self.imageIconView in: self.topImageEnumView];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[SwiftBoxedTypesAcceptingViewController class]]){
        
        SwiftBoxedTypesAcceptingViewController *swiftBoxedTypesAcceptingViewController
            = (SwiftBoxedTypesAcceptingViewController *)segue.destinationViewController;
        
        
        // Update User struct using a partial computed property userName - defined in our extension.
        self.userName = [NSString stringWithFormat: @"%@ + v2", self.userName];
        
        [swiftBoxedTypesAcceptingViewController setUser:self._user];
        [swiftBoxedTypesAcceptingViewController setColorIcon:self._colorIcon];
        [swiftBoxedTypesAcceptingViewController setImageIcon:self._imageIcon];
    }
}

-(void)addBorders {

    int CONTAINER_BORDER_WIDTH = 1;
    CGColorRef CONTAINER_BORDER_COLOR = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4].CGColor;
    [self.topStructView.layer setBorderColor:CONTAINER_BORDER_COLOR];
    [self.topStructView.layer setBorderWidth:CONTAINER_BORDER_WIDTH];
    
    [self.topColorEnumView.layer setBorderColor:CONTAINER_BORDER_COLOR];
    [self.topColorEnumView.layer setBorderWidth:CONTAINER_BORDER_WIDTH];
    
    [self.topImageEnumView.layer setBorderColor:CONTAINER_BORDER_COLOR];
    [self.topImageEnumView.layer setBorderWidth:CONTAINER_BORDER_WIDTH];
    
    [self.bottomStructView.layer setBorderColor:CONTAINER_BORDER_COLOR];
    [self.bottomStructView.layer setBorderWidth:CONTAINER_BORDER_WIDTH];
    
    [self.bottomColorEnumView.layer setBorderColor:CONTAINER_BORDER_COLOR];
    [self.bottomColorEnumView.layer setBorderWidth:CONTAINER_BORDER_WIDTH];
    
    [self.bottomImageEnumView.layer setBorderColor:CONTAINER_BORDER_COLOR];
    [self.bottomImageEnumView.layer setBorderWidth:CONTAINER_BORDER_WIDTH];
    
    [self.boxedSwiftTypesLabelsContainer.layer setBorderColor:CONTAINER_BORDER_COLOR];
    [self.boxedSwiftTypesLabelsContainer.layer setBorderWidth:CONTAINER_BORDER_WIDTH];
}


@end
