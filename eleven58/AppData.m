//
//  AppData.m
//  photodien
//
//  Created by Stuart Layton on 3/14/13.
//  Copyright (c) 2013 Stuart Layton. All rights reserved.
//

#import "AppData.h"

static AppData* inst = nil;

@implementation AppData
@synthesize saveImages;
@synthesize destAddr;

-(id)init {
    if(self=[super init]) {
        self.saveImages = NO;
        self.destAddr = @"nobody@example.com";
    }
    return self;
}

+(AppData*)instance {
    if (!inst) inst = [[AppData alloc] init];
    return inst;
}
@end