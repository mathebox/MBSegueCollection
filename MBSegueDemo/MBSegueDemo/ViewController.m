//
//  ViewController.m
//  MBSegueDemo
//
//  Created by Max Bothe on 01/01/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "ViewController.h"
#import "MBFadeSegue.h"

@implementation ViewController

- (IBAction)unwindToFirstViewController:(UIStoryboardSegue *)segue {};

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController
                                      fromViewController:(UIViewController *)fromViewController
                                              identifier:(NSString *)identifier
{
    if ([identifier isEqualToString:@"Fade"]) {
        MBSegue *fade = [[MBFadeSegue alloc] initWithIdentifier:identifier
                                                                   source:fromViewController
                                                              destination:toViewController];
        fade.type = MBSEgueTypeDismiss;
        return fade;
    }

    return [super segueForUnwindingToViewController:toViewController
                                 fromViewController:fromViewController
                                         identifier:identifier];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
