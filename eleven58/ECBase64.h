//
//  ECBase64.h
//  photodien
//
//  Created by Stuart Layton on 3/14/13.
//  Copyright (c) 2013 Stuart Layton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData ( NSDataBase64Additions )

+ (NSData*)dataWithBase64EncodedString: (NSString*)string;
- (id)initWithBase64EncodedString: (NSString*)string;

- (NSString*)base64Encoding;
- (NSString*)base64EncodingWithLineLength: (NSUInteger)lineLength;

@end