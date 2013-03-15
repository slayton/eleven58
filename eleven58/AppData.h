//
//  AppData.m
//  photodien
//
//  Created by Stuart Layton on 3/14/13.
//  Copyright (c) 2013 Stuart Layton. All rights reserved.
//

#import "AppData.h"

@interface AppData : NSObject

@property (nonatomic, retain, readwrite) NSString * destAddr;
@property (nonatomic, readwrite) BOOL saveImages;
-(id)init;
+(AppData*)instance;

@end
