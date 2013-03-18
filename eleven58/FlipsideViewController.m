//
//  FlipsideViewController.m
//  eleven58
//
//  Created by Stuart Layton on 3/14/13.
//  Copyright (c) 2013 Stuart Layton. All rights reserved.
//

#include "Utils.h"
#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

@synthesize host;
@synthesize port;
@synthesize user;
@synthesize pass;
@synthesize path;
@synthesize test;
@synthesize file;
@synthesize getFolder;

- (void)viewDidLoad
{
    [super viewDidLoad];
    host.text = [Utils getHostname];
    user.text = [Utils getUsername];
    pass.text = [Utils getPassword];
    path.text = [Utils getPath];
    file.text = [Utils getFilename];
    port.text = [Utils getPort];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)switchToggled:(id)sender{
    BOOL shouldSave = [sender isOn];
    NSLog(@"Switch flipped. State is:%d", shouldSave);
    [Utils setSaveFlag:shouldSave];
}

- (IBAction)doneEnteringText:(id)sender{

    NSLog(@"Done Entering Text!");
    
    if (sender == host)
    {
        NSLog(@"New host:%@", ((UITextField*)sender).text);
        [Utils setHostname:((UITextField*)sender).text];
    }
    if (sender == user)
    {
        NSLog(@"New user:%@", ((UITextField*)sender).text);
        [Utils setUsername:((UITextField*)sender).text];
    }
    if (sender == pass)
    {
        NSLog(@"New password");
        [Utils setPassword:((UITextField*)sender).text];
    }
    if (sender == path )
    {
        NSLog(@"New path:%@", ((UITextField*)sender).text);
        [Utils setPath:((UITextField*)sender).text];
    }
    if (sender == file)
    {
        NSLog(@"New file:%@", ((UITextField*)sender).text);
        [Utils setFilename:((UITextField *)sender).text];
    }
    if (sender == port)
    {
        NSLog(@"New port:%@", ((UITextField *) sender).text);
        [Utils setPort:((UITextField *) sender).text];
    }
}

- (IBAction) testConnection:(id)sender{
    
    
    if (![Utils testServerConnection])
        [[[UIAlertView alloc] initWithTitle:@"Connection Test" message:@"Unable to connect to server"
                              delegate:nil
                     cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
    else if (![Utils testIfFolderExists])
        [[[UIAlertView alloc] initWithTitle:@"Connection Test" message:@"Destination folder does not exist"             delegate:nil
                          cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    else
        [[[UIAlertView alloc] initWithTitle:@"Connection Test" message:@"Passed all tests!"             delegate:nil
                          cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
}
- (IBAction) getBaseFolder:(id)sender{
    NSString *dir = [Utils getBaseDirectory];
    path.text = dir;
    [self doneEnteringText:path];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
