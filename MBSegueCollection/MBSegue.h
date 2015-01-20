//
//  MBSegue.h
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

#import <UIKit/UIKit.h>

/**
 `MBSegueType` defines the purpose of the segue. Currently you can choose between presention a new
 view controller or dismissing a view controller.
 */
typedef NS_ENUM(NSUInteger, MBSegueType) {
    MBSegueTypePresent,
    MBSegueTypeDismiss
};

/**
 `MBSegue` is the abstract base class for segues in this collection. It contains multiple helper
 methods and stores basic customization properties like duratiob, delay and animation options.

 @warning You should never instantiate this class directly.
 */
@interface MBSegue : UIStoryboardSegue

/**
 The type of the segue.
 */
@property (nonatomic, assign) MBSegueType type;

/**
 The duration of the animation of the segue.
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 The delay before starting the animation of the segue.
 */
@property (nonatomic, assign) NSTimeInterval delay;

/**
 The animation options used for the animation.
 */
@property (nonatomic, assign) UIViewAnimationOptions options;

/**
 Create a snapshot of the current state of the source view.

 @return A snapshot of the source view.
 */
- (UIView *)sourceViewSnapshot;

/**
 Create a snapshot of the current state of the destination view.

 @return A snapshot of the destination view.
 */
- (UIView *)destinationViewSnapshot;

/**
 Mask a view with a given rectangle.

 @param view The view to be masked
 @param rect The rectangle defining the mask
 */
- (void)maskView:(UIView *)view withRect:(CGRect)rect;

/**
 Mask the left side of the given view

 @param view The view to be masked
 */
- (void)maskLeftSideOfView:(UIView *)view;

/**
 Mask the right side of the given view

 @param view The view to be masked
 */
- (void)maskRightSideOfView:(UIView *)view;

/**
 Changes the anchor point of a view without changing its position

 @param anchorPoint The new anchor point
 @param view The view for changing the anchor point
 */
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view;

/**
 Shows the destination view controller according the segue type without animation.

 @param completion The block called after displaying the destination view controler.
 */
- (void)showDestinationViewController:(void (^)())completion;

/**
 Add a shadow on the left side of a view with a given width.

 @param view The view that needs a shadow
 @param shadowWidth The width of the shadow

 @return A layer containing the view with the shadow
 */
- (CALayer *)addLeftShadowToView:(UIView *)view withWidth:(CGFloat)shadowWidth;

/**
 Add a shadow on the right side of a view with a given width.

 @param view The view that needs a shadow
 @param shadowWidth The width of the shadow

 @return A layer containing the view with the shadow
 */
- (CALayer *)addRightShadowToView:(UIView *)view withWidth:(CGFloat)shadowWidth;

/**
 Add a shadow on the right side of a view with a given width.

 @param view The view that needs a shadow
 @param shadowSize The size of the shadow
 @param shadowWidth The width of the shadow

 @return A layer containing the view with the shadow
 */
- (CALayer *)addShadowToView:(UIView *)view withSize:(CGSize)shadowSize withWidth:(CGFloat)shadowWidth;

@end
