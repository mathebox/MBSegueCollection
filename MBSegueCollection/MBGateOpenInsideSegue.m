//
//  MBGateOpenInsideSegue.m
//  MBSegueCollection
//
//  Created by Max Bothe on 03/01/15.
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

#import "MBGateOpenInsideSegue.h"

@implementation MBGateOpenInsideSegue

- (instancetype)initWithIdentifier:(NSString *)identifier
                            source:(UIViewController *)source
                       destination:(UIViewController *)destination
{
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        self.duration = 1.0;
        self.delay = 0.25;
        self.options = UIViewAnimationCurveEaseIn;
    }
    return self;
}

- (void)perform
{
    UIViewController *sourceViewController = self.sourceViewController;

    UIView *destinationViewSnapshot = self.destinationViewSnapshot;
    UIView *leftSide = self.sourceViewSnapshot;
    UIView *rightSide = self.sourceViewSnapshot;

    [self maskLeftSideOfView:rightSide];
    [self maskRightSideOfView:leftSide];

    [self setAnchorPoint:CGPointMake(0, 0.5) forView:leftSide];
    [self setAnchorPoint:CGPointMake(1, 0.5) forView:rightSide];

    [sourceViewController.view addSubview:destinationViewSnapshot];
    [sourceViewController.view addSubview:leftSide];
    [sourceViewController.view addSubview:rightSide];

    [UIView animateWithDuration:self.duration
                          delay:self.delay
                        options:self.options
                     animations:^{
                         CATransform3D t = CATransform3DIdentity;
                         t.m34 = 1.0 / 500; // set perspective
                         leftSide.layer.transform = CATransform3DRotate(t, -M_PI/2, 0.0f, 1.0f, 0.0f);
                         rightSide.layer.transform = CATransform3DRotate(t, M_PI/2, 0.0f, 1.0f, 0.0f);
                     }
                     completion:^(BOOL finished) {
                         [self showDestinationViewController:^{
                             [rightSide removeFromSuperview];
                             [leftSide removeFromSuperview];
                             [destinationViewSnapshot removeFromSuperview];
                         }];
                     }
     ];
}

@end
