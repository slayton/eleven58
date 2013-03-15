//
//  Utils.m
//  eleven58
//
//  Created by Stuart Layton on 3/14/13.
//  Copyright (c) 2013 Stuart Layton. All rights reserved.
//

#import "Utils.h"
#import "UIImage+Resize.h"
#import "KeychainItemWrapper.h"
#include <NMSSH/NMSSH.h>

#define kImageWidth 800
#define kImageHeight 600

@implementation Utils

+(BOOL) testServerConnection{
    NSLog(@"Testing server connection...");
    
    NMSSHSession * session = [Utils openConnection];
    if ( session != nil ){
        NSLog(@"PASSED!");
        
        [session disconnect];
        session = nil;
        NSLog(@"Disconnected");
        return YES;
    }
    
    NSLog(@"Failed!");
    return NO;    
}
+(NMSSHSession *) openConnection{
    NMSSHSession *session = [NMSSHSession connectToHost:[Utils getHostname]
                                           withUsername:[Utils getUsername]];
    if (![session isConnected])
    {
        NSLog(@"Failed to connect!");
        session = nil;
        return session;
    }    
    NSLog(@"\tConnected!");
    
    [session authenticateByPassword:[Utils getPassword]];
    
    if (![session isAuthorized])
    {
        NSLog(@"Failed to authenticate");
        session = nil;
        return session;
    }
    
    NSLog(@"Authenticated!");
    
    return session;

}
+(BOOL) uploadUIImageToServer:(UIImage *)img{

    // Open a connection, and check if valid
    NMSSHSession *session = [Utils openConnection];
    if (session == nil)
    {
        NSLog(@"Session error, unable to upload the image!");
        return NO;
    }
    
    // After opening the session save img to a file for uplaoding
    NSString* path = [NSHomeDirectory() stringByAppendingString:
                      [@"/Documents/" stringByAppendingString:[Utils getFilename]]];
    
    if (! [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil] ){
        NSLog(@"Error creating file %@", path);
        return NO;
    }
    NSFileHandle* myFileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    [myFileHandle writeData:UIImageJPEGRepresentation(img, .8)];
    [myFileHandle closeFile];
    
    // Attempt to upload the image
    if ( ![[session channel] uploadFile:path to:[Utils getPath]] )
    {
        NSLog(@"Upload failed!");
        return NO;
    }
    
    NSLog(@"Upload succesful!");
    
    // Disconnect the session and set to nil
    [session disconnect];
    session = nil;
    
    return YES;   
}


+(UIImage *) downsizeImage:(UIImage *)img{
    NSLog(@"IMG:%@", img);
    
    // Check if landscape or portrait
    if ( [img size].width > [img size].height)
        return [img resizedImage:CGSizeMake(kImageWidth, kImageHeight) interpolationQuality:kCGInterpolationHigh];
    else
        return [img resizedImage:CGSizeMake(kImageHeight, kImageWidth) interpolationQuality:kCGInterpolationHigh];
    
}

+(KeychainItemWrapper *) getKeychain{
    return [[KeychainItemWrapper alloc] initWithIdentifier:@"Credentials" accessGroup:nil];
}

+(NSUserDefaults *) getPrefernces{
    return [NSUserDefaults standardUserDefaults];
}

+(NSString *) getUsername{
    NSString *u = [[Utils getKeychain] objectForKey:(__bridge id)(kSecAttrAccount)];
    if (u != nil)
        return u ;
    return @"username";
}

+(NSString *) getPassword{
    NSString *p = [[Utils getKeychain] objectForKey:(__bridge id)(kSecValueData)];
    if (p != nil)
        return p;
    return @"password";
}

+(NSString *) getHostname{
    NSString *h = [[Utils getPrefernces] stringForKey:@"hostname"];
    if (h != nil)
        return h;
    else
        return @"host.example.com";
}

+(NSString *) getPath{
    NSString *p = [[Utils getPrefernces] stringForKey:@"path"];
    if (p != nil)
        return p;
    else
        return @"/path/to/upload/dir/";
}

+(NSString *) getFilename{
    NSString *f = [[Utils getPrefernces] stringForKey:@"filename"];
    if (f != nil)
        return f;
    else
        return @"dailyImage.jpg";
}

+(BOOL) getSaveFlag{
    return [[Utils getPrefernces] boolForKey:@"saveflag"];
}

+(void) setUsername:(NSString *) s{
    [[Utils getKeychain] setObject:s forKey:(__bridge id)(kSecAttrAccount)];
}
+(void) setPassword:(NSString *) s{
    [[Utils getKeychain] setObject:s forKey:(__bridge id)(kSecValueData)];
}
+(void) setHostname:(NSString *) s{
    NSUserDefaults *d = [Utils getPrefernces];
    [d setObject:s forKey:@"hostname"];
    [d synchronize];
}
+(void) setPath:(NSString *) s{
    NSUserDefaults *d = [Utils getPrefernces];
    [d setObject:s forKey:@"path"];
    [d synchronize];
}
+(void) setFilename:(NSString *)s{
    NSUserDefaults *d = [Utils getPrefernces];
    [d setObject:s forKey:@"filename"];
    [d synchronize];
}
+(void) setSaveFlag:(BOOL)b{
    NSUserDefaults *d = [Utils getPrefernces];
    [d setBool:b forKey:@"saveflag"];
    [d synchronize];
}

@end
