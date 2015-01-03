//
//  MBSimpleSplitClose.m
//  MBSegueCollection
//
//  Created by Max Bothe on 01/01/15.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Max Bothe
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "MBSimpleSplitCloseSegue.h"

@implementation MBSimpleSplitCloseSegue

- (instancetype)initWithIdentifier:(NSString *)identifier
                            source:(UIViewController *)source
                       destination:(UIViewController *)destination
{
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        self.duration = 0.75;
        self.delay = 0.25;
    }
    return self;
}

- (void)perform
{
    UIViewController *sourceViewController = self.sourceViewController;

    UIView *leftSide = self.destinationViewSnapshot;
    UIView *rightSide = self.destinationViewSnapshot;

    [self maskLeftSideOfView:leftSide];
    [self maskRightSideOfView:rightSide];

    // Move sides out of screen
    CGPoint newLeftCenter = leftSide.center;
    newLeftCenter.x -= leftSide.bounds.size.width/2;
    leftSide.center = newLeftCenter;

    CGPoint newRightCenter = rightSide.center;
    newRightCenter.x += rightSide.bounds.size.width/2;
    rightSide.center = newRightCenter;

    // Add subviews
    [sourceViewController.view addSubview:leftSide];
    [sourceViewController.view addSubview:rightSide];

    [UIView animateWithDuration:self.duration
                          delay:self.delay
                        options:self.options
                     animations:^{
                         CGPoint newLeftCenter = leftSide.center;
                         newLeftCenter.x += leftSide.bounds.size.width/2;
                         leftSide.center = newLeftCenter;

                         CGPoint newRightCenter = rightSide.center;
                         newRightCenter.x -= rightSide.bounds.size.width/2;
                         rightSide.center = newRightCenter;
                     }
                     completion:^(BOOL finished) {
                         [rightSide removeFromSuperview];
                         [leftSide removeFromSuperview];
                         [self showDestinationViewController];
                     }
     ];
}

@end
