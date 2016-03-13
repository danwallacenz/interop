//
//  OldStyleViewController.h
//  interop
//
//  Created by Daniel Wallace on 11/03/16.
//  Copyright © 2016 IkeGPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OldStyleViewController : UIViewController

/**
 'Boxing' a Swift enum for storing it in an Objective-C object.
  Can store the Icon enum and pass it on to something else.
  Cannot define storage in an extension. See OldStyleViewController.swift.
 */
@property (readwrite, strong) id /* Box<Icon> */ _icon;


/**
 interfaces of shims to allow passing a Swift enum to an Objective-C class
 see OldStyleViewController.swift
 */
-(void)showIconViewWithColor:(UIColor *)color;
-(void)showIconViewWithImage:(UIImage *)image;

@end
