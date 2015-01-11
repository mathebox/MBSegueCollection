# MBSegueCollection

MBSegueCollection is a growing collection of different custom segues for iOS 6 or later. All segues can be used to present or to dismiss view controllers.

[![Build Status](https://img.shields.io/travis/mathebox/MBSegueCollection.svg?style=flat)](https://travis-ci.org/mathebox/MBSegueCollection) [![Cocoapods](https://img.shields.io/cocoapods/v/MBSegueCollection.svg?style=flat)](http://cocoapods.org/?q=mbseguecollection) ![Platform](https://img.shields.io/cocoapods/p/MBSegueCollection.svg?style=flat) ![License](https://img.shields.io/cocoapods/l/MBSegueCollection.svg?style=flat)

# Install
- Requirement: iOS 6


### via CocoaPods
- Add `pod ‘MBSegueCollection’` to your [Podfile](http://cocoapods.org/)
- Run `pod install`
- Run `open App.xcworkspace`

### manually
- or copy the source files from the MBSegueCollection directory to your project

# Getting started
All segues can be used to present new view controllers or to dismiss one or multiple view controllers.

## Present new view controllers
1. Create a custom segue in your storyboard file

  ![present new view controller 1](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/present_new_view_controller_1.png)
2. Set the class of the segue

  ![present new view controller 2](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/present_new_view_controller_2.png)
3. You can customize the segue in `prepareForSegue:sender:`. For detailed customization options, check out the [demo](https://github.com/mathebox/MBSegueCollection#demo) section.

  Example:
  ```objc
  - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
  {
      if ([segue.identifier isEqualToString:@"Fade"]) {
          MBFadeSegue *fadeSegue = (MBFadeSegue *)segue;
          fadeSegue.duration = 1.0;
     }
  }
  ```

## Dismiss view controllers
1. Implement a method in the destination view controller with the following schema: ```- (IBAction)YOUR_COOL_METHOD_NAME:(UIStoryboardSegue *)segue```. This enables to create an unwind segue to this view controller.
2. Create an unwind segue by `Ctrl+Drag` from a button (or the view controller) to the `exit` icon.

  ![dismiss view controller 2a](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/dismiss_view_controller_2a.png)
![dismiss view controller 2b](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/dismiss_view_controller_2b.png)
![dismiss view controller 2c](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/dismiss_view_controller_2c.png)
3. Set the name of the unwind segue.
4. Implement `segueForUnwindingToViewController:fromViewController:identifier:` in the destination view controller and return the segue according to the identifier. If the identifier does not match any of your custom segues, return the result of the superclass. In this method you can customize the segue. For detailed customization options, check out the [demo](https://github.com/mathebox/MBSegueCollection#demo) section.

  Example:
  ```objc
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
  ```

**Note: It’s very important to set the `type` of the MBSegue to `MBSegueTypeDismiss`. Otherwise it will break your application.**

# Customize
The following properties of all segues are customizable:
- **duration** (NSTimeInterval)
- **delay** (NSTimeInterval)
- **options** (UIViewAnimationOptions)

# Demo
![simple slide open segue](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/segue_simple_slide_open.gif)
![simple slide open segue](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/segue_simple_slide_close.gif)
![gate open inside](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/segue_gate_open_inside.gif)
![gate close inside](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/segue_gate_close_inside.gif)
![gate open outside](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/segue_gate_open_outside.gif)
![gate close outside](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/segue_gate_close_outside.gif)
![fade segue](https://raw.githubusercontent.com/mathebox/MBSegueCollection/master/assets/segue_fade.gif)

# Todo
- more segues
- more segues
- more segues

# License
The MIT License (MIT)

Copyright (c) 2015 Max Bothe

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
