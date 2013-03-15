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

+(BOOL) testServerConnection;

+(NSString *) getUsername;
+(NSString *) getHostname;
+(NSString *) getPath;
+(NSString *) getPassword;
+(BOOL) getSaveFlag;;

+(void) setUsername:(NSString*)s;
+(void) setHostname:(NSString*)s;
+(void) setPath:(NSString*)s;
+(void) setPassword:(NSString*)s;
+(void) setSaveFlag:(BOOL)b;

@end
