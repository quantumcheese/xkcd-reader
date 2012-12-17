//
//  QCAppDelegate.h
//  Xkcd Reader
//
//  Created by Richard Brown on 12/17/12.
//  Copyright (c) 2012 Quantumcheese Coding, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QCViewController;

@interface QCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) QCViewController *viewController;

@end
