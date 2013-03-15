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
@synthesize user;
@synthesize pass;
@synthesize path;
@synthesize test;
@synthesize file;


- (void)viewDidLoad
{
    [super viewDidLoad];
    host.text = [Utils getHostname];
    user.text = [Utils getUsername];
    pass.text = [Utils getPassword];
    path.text = [Utils getPath];
    file.text = [Utils getFilename];
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
}

- (IBAction) testConnection:(id)sender{
    
    NSString * msg = [Utils testServerConnection] ? @"Passed!" :  @"Failed!";
    
   [[[UIAlertView alloc] initWithTitle:msg message:[@"Connection Test " stringByAppendingString:msg] delegate:nil
                     cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
