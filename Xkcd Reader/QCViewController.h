//
//  QCViewController.h
//  Xkcd Reader
//
//  Created by Richard Brown on 12/17/12.
//  Copyright (c) 2012 Quantumcheese Coding, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCViewController : UIViewController <NSXMLParserDelegate>
{
    __weak IBOutlet UIImageView *comicView;
    __weak IBOutlet UITextField *altText;
    NSString *next, *previous;
    BOOL insideComicDiv;
}

- (IBAction)goToFirst:(id)sender;
- (IBAction)goToPrevious:(id)sender;
- (IBAction)goToRandom:(id)sender;
- (IBAction)goToNext:(id)sender;
- (IBAction)goToLast:(id)sender;

@end
