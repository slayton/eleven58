//
//  FlipsideViewController.h
//  eleven58
//
//  Created by Stuart Layton on 3/14/13.
//  Copyright (c) 2013 Stuart Layton. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController <FlipsideViewControllerDelegate, UITextFieldDelegate>{
    UITextField * host;
    UITextField * port;
    UITextField * user;
    UITextField * pass;
    UITextField * path;
    UITextField * file;
    UIButton * test;
    UIButton * getFolder;
}

@property (nonatomic, retain) IBOutlet UITextField * host;
@property (nonatomic, retain) IBOutlet UITextField * port;
@property (nonatomic, retain) IBOutlet UITextField * user;
@property (nonatomic, retain) IBOutlet UITextField * pass;
@property (nonatomic, retain) IBOutlet UITextField * path;
@property (nonatomic, retain) IBOutlet UITextField * file;
@property (nonatomic, retain) IBOutlet UIButton * test;
@property (nonatomic, retain) IBOutlet UIButton * getFolder;

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction) done:(id)sender;
- (IBAction) switchToggled:(id)sender;
- (IBAction) doneEnteringText:(id)sender;
- (IBAction) testConnection:(id)sender;


@end
