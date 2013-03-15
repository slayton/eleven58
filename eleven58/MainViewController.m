//
//  MainViewController.m
//  eleven58
//
//  Created by Stuart Layton on 3/14/13.
//  Copyright (c) 2013 Stuart Layton. All rights reserved.
//


// TO DO


#import "MainViewController.h"
#import "Utils.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize imageView;
@synthesize uploadButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showInfo:(id)sender
{
    FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (IBAction) photoButtonPressed:(id)sender{
    
    NSLog(@"photoButtonPressed!");
    [self startCameraOrGallery];
    
}

-(IBAction) uploadButtonPressed:(id)sender{

    NSLog(@"UploadButtonPressed");
    NSLog(@"Uploading image with size:%f x %f",
          [imageView.image size].width, [imageView.image size].height);
    BOOL b = [Utils uploadUIImageToServer:imageView.image];
    
    
    NSString *title = b ? @"Sucess!" : @"Failed!";
    NSString *msg   = b ? @"Atta boy!" : @"Damn, check the settings and try again.";
    [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil
                     cancelButtonTitle:@"OK" otherButtonTitles:nil] show];

}


- (void) startCameraOrGallery{
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] )
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (__bridge NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        newMedia = YES;
        
    }
    else if ( [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum] )
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (__bridge NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary*) info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"finished picking media with type:%@", mediaType);
    
    [self dismissViewControllerAnimated:YES completion:nil];

    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        
        
        image = [Utils downsizeImage:image];
        [self.imageView setImage:image];
        [uploadButton setEnabled:YES];
        
        if (newMedia  && [Utils getSaveFlag])
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeMovie])
    {
        NSLog(@"Invalid media type");
		// Code here to support video if enabled
	}

}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)composeEmailMessage {
    
    NSData *imgData = UIImagePNGRepresentation( [Utils downsizeImage:imageView.image]);
    
    NSLog(@"Composing email");
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        
        mailViewController.mailComposeDelegate = self;
       
        [mailViewController setSubject:@"Subject Goes Here."];
        [mailViewController setMessageBody:@"Your message goes here." isHTML:NO];
        [mailViewController setToRecipients:[NSArray arrayWithObject: @"stuart.layton@gmail.com"]];
        [mailViewController addAttachmentData:imgData mimeType:@"image/jpeg" fileName:@"photo name"];
        
        [self presentViewController:mailViewController animated:YES completion:nil];
        return YES;
    }
          
    NSLog(@"Device is unable to send email in its current state.");
    return NO;
}


-(void) mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
