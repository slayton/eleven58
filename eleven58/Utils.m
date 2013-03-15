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
    
    if ( [Utils doTest] ){
        NSLog(@"PASSED!");
        return YES;
    }
    NSLog(@"Failed!");
    return NO;    
}
+(BOOL) doTest{
//    NMSSHSession *session = [NMSSHSession connectToHost:[Utils getHostname]
//                                           withUsername:[Utils getUsername]];
//    if (![session isConnected])
//        return NO;
//    
//    NSLog(@"\tConnected!");
//    
//    [session authenticateByPassword:[Utils getPassword]];
//    
//    if (![session isAuthorized])
//        return NO;
//    
//    NSLog(@"Authorized!");
//    
//    [session disconnect];
//    session = nil;
//    NSLog(@"Disconnected");
//    
//    return YES;
    return NO;
}
+(BOOL) uploadUIImageToServer:(UIImage *)img{
    
//    NMSSHSession *session = [NMSSHSession connectToHost:@"example.com"
//                                           withUsername:@"username"];
//    
//    if (![session isConnected])
//    {
//        NSLog(@"Failed to create session!");
//        return NO;
//    }
//    
//    NSLog(@"Session object connected!");
//    
//    [session authenticateByPassword:@"secretPassword"];
//    
//    if ( ![session isAuthorized] ) {
//        NSLog(@"Authentication failed!");
//        return NO;
//    }
//    
//    NSLog(@"Session object authenticated!");
//    
//    NSString* path = [NSHomeDirectory() stringByAppendingString:@"/Documents/theImage.jpg"];
//    
//    if (! [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil] ){
//        NSLog(@"Error creating file %@", path);
//        return NO;
//    }
//    
//    NSFileHandle* myFileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
//    [myFileHandle writeData:UIImagePNGRepresentation(img)];
//    [myFileHandle closeFile];
//    
//    if ( ![[session channel] uploadFile:path to:@"/home/user/destDir/"] )
//    {
//        NSLog(@"Upload failed!");
//        return NO;
//    }
//    
//    NSLog(@"Upload succesful!");
//    [session disconnect];
//    session = nil;
//    return YES;
    return NO;
    
}


+(UIImage *) downsizeImage:(UIImage *)img{
    NSLog(@"IMG:%@", img);
    return [img resizedImage:CGSizeMake(kImageWidth, kImageHeight) interpolationQuality:kCGInterpolationHigh];
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
+(void) setSaveFlag:(BOOL)b{
    NSUserDefaults *d = [Utils getPrefernces];
    [d setBool:b forKey:@"saveflag"];
    [d synchronize];
}

@end
