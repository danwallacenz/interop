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
 interfaces of shims to allow passing a Swift enum to an Objective-C class
 see OldStyleViewController.swift
 */
-(void)showIconViewWithColor:(UIColor *)color;
-(void)showIconViewWithImage:(UIImage *)image;

@end
