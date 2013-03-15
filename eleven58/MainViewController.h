//
//  MainViewController.h
//  eleven58
//
//  Created by Stuart Layton on 3/14/13.
//  Copyright (c) 2013 Stuart Layton. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "FlipsideViewController.h"


@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate>
{
    UIButton *uploadButton;
    UIImageView *imageView;
    BOOL newMedia;
    BOOL hasPicture;
}
@property (nonatomic, retain) IBOutlet UIButton *uploadButton;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
- (IBAction)showInfo:(id)sender;
- (IBAction)photoButtonPressed:(id)sender;
- (IBAction)uploadButtonPressed:(id)sender;


@end
