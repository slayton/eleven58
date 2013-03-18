//
//  Utils.h
//  eleven58
//
//  Created by Stuart Layton on 3/14/13.
//  Copyright (c) 2013 Stuart Layton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(BOOL) uploadUIImageToServer:(UIImage *) img;
+(UIImage *) downsizeImage:(UIImage *) img;

+(NSString *) getBaseDirectory;
+(BOOL) testServerConnection;
+(BOOL) testIfFolderExists;

+(NSString *) getUsername;
+(NSString *) getHostname;
+(NSString *) getPath;
+(NSString *) getPassword;
+(NSString *) getFilename;
+(NSString *) getPort;
+(BOOL) getSaveFlag;

+(void) setUsername:(NSString*)s;
+(void) setHostname:(NSString*)s;
+(void) setPort:(NSString*)s;
+(void) setPath:(NSString*)s;
+(void) setFilename:(NSString *)s;
+(void) setPassword:(NSString*)s;
+(void) setSaveFlag:(BOOL)b;

@end
