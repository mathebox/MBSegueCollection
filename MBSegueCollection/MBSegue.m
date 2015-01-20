//
//  MBSegue.m
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

#import "MBSegue.h"

@implementation MBSegue

- (instancetype)initWithIdentifier:(NSString *)identifier
                            source:(UIViewController *)source
                       destination:(UIViewController *)destination
{
    if ([self isMemberOfClass:[MBSegue class]]) {
        [self doesNotRecognizeSelector:_cmd];
        return nil;
    }

    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        self.type = MBSegueTypePresent;
        self.duration = 0.5;
        self.delay = 0.0;
        self.options = UIViewAnimationOptionCurveEaseInOut;
    }

    return self;
}

- (UIView *)sourceViewSnapshot
{
    UIViewController *sourceViewController = self.sourceViewController;
    return [sourceViewController.view snapshotViewAfterScreenUpdates:NO];
}

- (UIView *)destinationViewSnapshot
{
    UIViewController *destinationViewController = self.destinationViewController;
    UIGraphicsBeginImageContextWithOptions(destinationViewController.view.bounds.size, NO, 0);
    [destinationViewController.view drawViewHierarchyInRect:destinationViewController.view.bounds
                                         afterScreenUpdates:YES];
    UIImage *destinationViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [[UIImageView alloc] initWithImage:destinationViewImage];
}

- (void)maskView:(UIView *)view withRect:(CGRect)rect
{
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    CGPathRef path = CGPathCreateWithRect(rect, NULL);
    mask.path = path;
    CGPathRelease(path);
    view.layer.mask = mask;
}

- (void)maskLeftSideOfView:(UIView *)view
{
    CGRect rect = CGRectMake(view.bounds.size.width/2, view.bounds.origin.y,
                             view.bounds.size.width/2, view.bounds.size.height);
    [self maskView:view withRect:rect];
}

- (void)maskRightSideOfView:(UIView *)view;
{
    CGRect rect = CGRectMake(view.bounds.origin.x, view.bounds.origin.y,
                             view.bounds.size.width/2, view.bounds.size.height);
    [self maskView:view withRect:rect];
}

- (void)showDestinationViewController
{
    [self showDestinationViewController:NULL];
}

- (void)showDestinationViewController:(void (^)())completion
{
    if (self.type == MBSegueTypeDismiss) {
        [self.destinationViewController dismissViewControllerAnimated:NO
                                                           completion:completion];
    } else {
        [self.sourceViewController presentViewController:self.destinationViewController
                                                animated:NO
                                              completion:completion];
    }
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x,
                                   view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x,
                                   view.bounds.size.height * view.layer.anchorPoint.y);

    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);

    CGPoint position = view.layer.position;

    position.x -= oldPoint.x;
    position.x += newPoint.x;

    position.y -= oldPoint.y;
    position.y += newPoint.y;

    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

#pragma - Shadows

- (CALayer *)addLeftShadowToView:(UIView *)view withWidth:(CGFloat)shadowWidth
{
    return [self addShadowToView:view withSize:CGSizeMake(-shadowWidth, 0.f) withWidth:shadowWidth];
}

- (CALayer *)addRightShadowToView:(UIView *)view withWidth:(CGFloat)shadowWidth
{
    return [self addShadowToView:view withSize:CGSizeMake(shadowWidth, 0.f) withWidth:shadowWidth];
}

- (CALayer *)addShadowToView:(UIView *)view withSize:(CGSize)shadowSize withWidth:(CGFloat)shadowWidth
{
    CALayer* containerLayer = [CALayer layer];
    containerLayer.shadowColor = [UIColor blackColor].CGColor;
    containerLayer.shadowRadius = 2*shadowWidth;
    containerLayer.shadowOffset = shadowSize;
    containerLayer.shadowOpacity = 0.5f;

    [containerLayer addSublayer:view.layer];

    return containerLayer;
}

@end
